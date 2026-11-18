"""
Remove tiles that a seed task would not write: tiles outside the task's coverage.

Seeding with metatiles stores every tile of a metatile that touches the coverage, so each seed run
leaves (mostly white) tiles outside it. This lists the task's cache directory in Azure Blob Storage,
level by level, and removes blobs whose tile does not intersect the coverage. It uses the same
seed config, grid, coverage and blob names (``AzureBlobCache.tile_key``) as mapproxy-seed, and
the same test the seeder uses to decide which tiles to seed.

Dry run by default: it only counts. Pass --delete to remove.
The seed job runs it after seeding through seed_then_cleanup.py.

Credentials: by default the cache's own connection (AZURE_STORAGE_CONNECTION_STRING, as the seed
job uses). With --account NAME it uses your az login instead (needs the azure-identity package).

In the seed image:
    python /app/tools/remove_tiles_outside_coverage.py --seed lufo_rd
Locally, against a private storage account (az login, private endpoint reachable):
    python src/tools/remove_tiles_outside_coverage.py --seed lufo_wm --account stlufoglfdpgoontweu01
"""
import argparse
import collections
import os
import sys
from concurrent.futures import ThreadPoolExecutor

from mapproxy.cache.tile import Tile
from mapproxy.config import local_base_config
from mapproxy.config.loader import load_configuration
from mapproxy.seed.config import load_seed_tasks_conf

HERE = os.path.dirname(os.path.abspath(__file__))
APP = os.path.dirname(HERE)


def parse_args():
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument('--seed', required=True, action='append',
                   help='seed name(s) from seed.yaml, comma separated or repeated, e.g. lufo_rd')
    p.add_argument('-s', '--seed-conf', default=os.path.join(APP, 'seed.yaml'))
    p.add_argument('-f', '--proxy-conf', default=os.path.join(APP, 'mapproxy-seed.yaml'))
    p.add_argument('--account', help='storage account name; use az login instead of the connection string')
    p.add_argument('--delete', action='store_true', help='actually delete (default: dry run)')
    p.add_argument('--list', metavar='FILE', help='write the names of the tiles outside the coverage to FILE')
    p.add_argument('--workers', type=int, default=16, help='parallel deletes (default 16)')
    return p.parse_args()


def split_names(values):
    """['a,b', 'c'] -> ['a', 'b', 'c'], like mapproxy-seed --seed."""
    return [n.strip() for v in values for n in v.split(',') if n.strip()]


def container_client(cache, account):
    if not account:
        return cache.container_client
    try:
        from azure.identity import AzureCliCredential
    except ImportError:
        sys.exit('--account needs the azure-identity package: pip install azure-identity')
    from azure.storage.blob import BlobServiceClient
    return (BlobServiceClient(f'https://{account}.blob.core.windows.net', credential=AzureCliCredential())
            .get_container_client(cache.container_name))


def tile_coord(name, prefix, ext):
    """'lufo2025_RD/12/1890/2153.jpeg' -> (1890, 2153, 12); None for anything else (e.g. directory blobs)."""
    if not (name.startswith(prefix) and name.endswith('.' + ext)):
        return None
    parts = name[len(prefix):-len(ext) - 1].split('/')
    if len(parts) != 3 or not all(p.isdigit() for p in parts):
        return None
    z, x, y = map(int, parts)
    return x, y, z


def remove_outside(seed_conf, proxy_conf, seed_names, delete=False, account=None, list_file=None, workers=16):
    """Count (and with delete=True remove) the tiles outside the coverage of each seed. Returns the count."""
    conf = load_configuration(proxy_conf, seed=True)
    with local_base_config(conf.base_config):
        tasks = load_seed_tasks_conf(seed_conf, conf).seeds(seed_names)

    out = open(list_file, 'w') if list_file else None
    total_outside = 0
    for task in tasks:
        cache = task.tile_manager.cache
        grid = task.grid
        if not hasattr(cache, 'tile_key') or not hasattr(cache, 'container_name'):
            raise ValueError(f"{task.md['name']}: cache is not an azureblob cache")
        client = container_client(cache, account)
        prefix = cache.base_path.strip('/') + '/'
        print(f"== remove tiles outside the coverage of {task.md['name']}: "
              f"{client.account_name}/{cache.container_name}/{prefix} "
              f"grid {task.md['grid_name']}, levels {task.levels[0]}-{task.levels[-1]}"
              f"{'' if delete else ' (dry run)'}", flush=True)

        for z in task.levels:
            seen = outside = skipped = 0
            sizes = collections.Counter()
            names = []
            for blob in client.list_blobs(name_starts_with=f'{prefix}{z}/'):
                coord = tile_coord(blob.name, prefix, cache.file_ext)
                if coord is None:
                    skipped += 1
                    continue
                # same blob name as the cache would use for this tile, so the coordinates are read right
                if cache.tile_key(Tile(coord)) != blob.name:
                    raise ValueError(f'unexpected blob name {blob.name} '
                                     f'(cache would use {cache.tile_key(Tile(coord))})')
                seen += 1
                # the test the seeder applies per (meta)tile
                if not task.intersects(grid.tile_bbox(coord)):
                    outside += 1
                    sizes[blob.size] += 1
                    names.append(blob.name)
            if out:
                out.writelines(n + '\n' for n in names)
            if delete and names:
                with ThreadPoolExecutor(workers) as pool:
                    list(pool.map(client.delete_blob, names))
            total_outside += outside
            common = ', '.join(f'{n}x {s} B' for s, n in sizes.most_common(3))
            print(f'  z{z}: {seen} tiles, {outside} outside the coverage'
                  f"{' (deleted)' if delete and outside else ''}"
                  f"{f'; most common sizes: {common}' if outside else ''}"
                  f"{f'; {skipped} other blobs ignored' if skipped else ''}", flush=True)

    if out:
        out.close()
    print(f"{'deleted' if delete else 'would delete'}: {total_outside} tiles", flush=True)
    return total_outside


def main():
    args = parse_args()
    remove_outside(args.seed_conf, args.proxy_conf, split_names(args.seed), delete=args.delete,
                   account=args.account, list_file=args.list, workers=args.workers)


if __name__ == '__main__':
    main()
