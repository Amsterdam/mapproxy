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

The `MAPSERVER_URL_REPLACE` placeholder in `mapproxy-seed.yaml` is filled at build time from the `MAPSERVER_URL` build arg (the k8s pipeline passes its `MAPS_URL` as `EXTRA_ARG2`, so each env seeds from its own mapserver). It is the mapserver base url; `https://host`, `host` and `host/tiled` all work (the Dockerfile normalizes to `https://host`) and `/tiled/maps/...` is added in `mapproxy-seed.yaml`:

* dev (`compose.yml`, `compose-seed.yml`): `https://map.data-o.azure.amsterdam.nl`
* prd (no build arg): the Dockerfile default `https://map.data.amsterdam.nl`

## Support

If we need help with MapProxy, we can contact the following person:

Edward Mac Gillavry
webmapper.net