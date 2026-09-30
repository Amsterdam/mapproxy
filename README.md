## Overview

This repository contains a [MapProxy application](https://mapproxy.org/) for the Datapunt Map project. It provides a UWSGI-based WMTS and WMS server to serve pre-generated tiles from a storage backend (typically an object store).

`mapproxy.yaml` - Mapproxy generic config, this defines the services, sources, caches, layers and globals

## Config files

* `mapproxy.yaml` - MapProxy WMTS config, this defines the service, sources, caches, layers and globals for the WMTS server.
* `mapproxy-seed.yaml` - Defines the sources and caches used in seeding the basiskaarten and luchtfotos.
* `seed.yaml` - MapProxy caching configuration defines the caches to build and their bboxes and zoom levels.

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

The `MAPSERVER_URL_REPLACE` placeholder in `mapproxy-seed.yaml` is filled at build time from the `MAPSERVER_URL` build arg. It defaults to the o mapserver `https://map.data-o.azure.amsterdam.nl` in every environment; the env's own mapserver that the k8s pipeline passes as `EXTRA_ARG2` (`MAPS_URL`) is deliberately not used, because not every env's mapserver has data. Override with `--build-arg MAPSERVER_URL=...`; `https://host`, `host` and `host/tiled` all work (the Dockerfile normalizes to `https://host`) and `/tiled/maps/...` is added in `mapproxy-seed.yaml`.

## Support

If we need help with MapProxy, we can contact the following person:

Edward Mac Gillavry
webmapper.net