## Overview

This repository contains a [MapProxy application](https://mapproxy.org/) for the Datapunt Map project. It provides a UWSGI-based WMTS and WMS server to serve pre-generated tiles from a storage backend (typically an object store).

`mapproxy.yaml` - Mapproxy generic config, this defines the services, sources, caches, layers and globals

## Config files

* `mapproxy.yaml` - MapProxy WMTS config, this defines the service, sources, caches, layers and globals for the WMTS server.
* `mapproxy-seed.yaml` - Defines the sources and caches used in seeding the basiskaarten and luchtfotos.
* `seed.yaml` - MapProxy caching configuration defines the caches to build and their bboxes and zoom levels.
* `coverage_kaart.geojson` - The map bbox 90000,464250,175000,520000 (EPSG:28992) as a polygon. The `topografie*_kbk` sources clip on it, so the zoomed-out (kbk) levels show no map outside the bbox. Only the `topo_*_kbk_cache` caches (used by the `*_kbk` seeds) have this clip; the bgt seeds use the unclipped `topo_*_cache` on the same blob folders, because clipping re-encodes every meta tile (about 0.12 s each) and the bgt bbox lies inside the map bbox anyway. All topo caches set `quantizer: mediancut`: MapProxy re-quantizes a tile whenever it re-encodes it, also without clip when MapServer's palette has fewer than 256 entries (RD 6-7, WM 11-12), and the default quantizer then keeps only about 35 of the 250 colours.

Run this for local development (Windows)

```bash
    setx OS_URL "t1.data.amsterdam.nl"
    docker compose up
```

This will spawn a MapProxy container that serves WMTS and WMS services from the acceptance object store that contains pre-generated tiles.

## Seeding

To fill the Azure Blob store container with new tiles, run this (Linux):

```bash
    export AZURE_STORAGE_CONNECTION_STRING=DefaultEndpointsProtocol=https;AccountName=my-storage-account;AccountKey=my-key
    ./start_tiles {rd|rd_light|rd_zw|rd_lufo|wm|wm_light|wm_zw|wm_lufo}
```

The `MAPSERVER_URL_REPLACE` placeholder in `mapproxy-seed.yaml` is filled at build time from the `MAPSERVER_URL` build arg. It defaults to the env's own mapserver, which the k8s pipeline passes as `EXTRA_ARG2` (`MAPS_URL`), so prd seeds from the prd mapserver. It falls back to the o mapserver `https://map.data-o.azure.amsterdam.nl` when `EXTRA_ARG2` is unset, and for test, because test's mapserver has no data. Override with `--build-arg MAPSERVER_URL=...`; `https://host`, `host` and `host/tiled` all work (the Dockerfile normalizes to `https://host`) and `/tiled/maps/...` is added in `mapproxy-seed.yaml`.

## Support

If we need help with MapProxy, we can contact the following person:

Bastiaan du Pon
datapunt@amsterdam.nl
