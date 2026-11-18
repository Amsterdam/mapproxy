"""
Run mapproxy-seed, then remove the tiles outside the coverage of the same seeds.

Seeding with metatiles (meta_size [4, 4]) writes every tile of a metatile that touches the coverage,
so each run, refresh runs included, leaves white tiles outside it. Seeding with meta_size [1, 1]
avoids that but makes MapServer 6-10x slower per tile. So the seed job seeds with metatiles and
then runs remove_tiles_outside_coverage.py for the same seeds.

Takes the mapproxy-seed arguments unchanged; used as the seed job's command (dpgo, modules/aci_tiling):
    python3 /app/tools/seed_then_cleanup.py -c 2 -s /app/seed.yaml -f /app/mapproxy-seed.yaml --seed=lufo_rd -q

- The cleanup only runs after a successful seed, and only for the seeds given with --seed.
- With --dry-run the cleanup is a dry run too (it only counts); with --summary it is skipped.
- If the cleanup fails, the error is logged and the exit code stays 0: the seed itself succeeded,
  and with restart_policy OnFailure a non-zero exit would start the whole seed again.
- Waits SEED_START_DELAY_SECONDS first, if set (like the delayed command in aci_tiling).
"""
import multiprocessing
import os
import sys
import time
import traceback

# Python 3.14 defaults to 'spawn', which breaks mapproxy-seed (the Azure SDK keeps a thread-local
# that cannot be pickled). Same as the inline command in dpgo modules/aci_tiling.
multiprocessing.set_start_method('fork', force=True)

from mapproxy.seed.script import SeedScript, main as seed_main  # noqa: E402

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from remove_tiles_outside_coverage import remove_outside, split_names  # noqa: E402


def main():
    delay = int(os.environ.get('SEED_START_DELAY_SECONDS') or 0)
    if delay > 0:
        print('seed start delayed', delay, 's', flush=True)
        time.sleep(delay)

    args = sys.argv[1:]
    options, _ = SeedScript.parser.parse_args(args)

    sys.argv = ['mapproxy-seed'] + args
    rc = seed_main()
    if rc:
        print(f'mapproxy-seed exited with {rc}; cleanup skipped', flush=True)
        return rc
    if options.summary:
        return 0
    if not options.seed_names or split_names(options.seed_names) == ['ALL']:
        print('no explicit --seed given; cleanup skipped', flush=True)
        return 0

    try:
        remove_outside(options.seed_file, options.conf_file, split_names(options.seed_names),
                       delete=not options.dry_run)
    except Exception:
        traceback.print_exc()
        print('CLEANUP FAILED: tiles outside the coverage were not removed (the seed itself succeeded)',
              flush=True)
    return 0


if __name__ == '__main__':
    sys.exit(main())
