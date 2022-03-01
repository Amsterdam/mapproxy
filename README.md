## Overview

This repository contains a [MapProxy application](https://mapproxy.org/) for the Datapunt Map project. See [here](https://dev.azure.com/CloudCompetenceCenter/Data%20Diensten/_wiki/wikis/Data-Diensten.wiki/3030/Map-project) for a schematic overview of the current architecture.
Within this project it serves multiple purposes:

    1 provide configuration and shell-scripts to pre-generate tiles using the [Amsterdam mapserver](https://github.com/Amsterdam/mapserver) WMS as input
    2 provide a UWSGI-based WMTS server to serve these pre-generated tile-images from a storage backend (typically an objectstore)

The WMTS server automatically uses all configured layers with a name and a single cached source

## Config files

`mapproxy-base.yaml` - Shared globals and grids for the WMTS server and seeding jobs
`mapproxy.yaml` - MapProxy WMTS config, this defines the service, sources, caches, layers and globals for the WMTS server.
`mapproxy-seed.yaml` - Defines the sources and caches used in seeding the basiskaarten and luchtfotos.
`seed.yaml` - MapProxy cache configuration, this defines which sources should be used to pre-generate tiles and to what destinations these should be written.

Run this for local development

```bash
  mapproxy-util serve-develop mapproxy-local.yaml
```

This will spawn a hot reloading wmts server which serves from the objectstore. Note that the layers only work
starting from zoomlevel 5 but the generated OpenLayers client does not take the constraints of the layers
into account, so you have to zoom to see the tiles appear.

In this local setup, tms tiles are cached in the `local` directory, which can grow to considerable size if all zoomlevels are requested.

---------------------

## Tile pre-generation jobs

Project location: <https://ci.data.amsterdam.nl/job/DataServices/job/Tiles/>

Do not change the following value 1, otherwise the mapserver will crash. ( apache2 - mapserver )
The mapserver is tuned (project mapserver - branch basis)

```bash
mapproxy-seed -c 1 -s /app/seed.yaml -f /app/mapproxy.yaml --seed=topo_rd_kbk,topo_rd_bgt
```

You can start the following job

This job is starting a internal webserver( apache2 > mapserver > and is generating on de build slaves the new images. The script is copying the tiles to /mnt/tiles. after the build process is done. The tiles will be uploaded to the objectstore in the next job.

## Global settings

meta_size: If you set this to a higher value for example 8 x 8 the internal mapserver is crashing.
mea_buffer: do not change this.

```bash
globals:
  cache:
    base_dir: '/app'
    lock_dir: '/app'
    tile_lock_dir: '/app'
    meta_size: [4, 4]
    meta_buffer: 254
  http:
    ssl_no_cert_checks: True
    client_timeout: 10
```

### Luchtfoto tegels

Creating a new Lufo year of tiles and service follow these steps:

- Copy the aerial pictures (tif) to localhost
- Run [lufopyramids.sh in mapserver repo](https://github.com/Amsterdam/mapserver/blob/master/tools/lufopyramids.sh) (see comments in file)
- Start mapserver docker
- Run mapproxy docker:

```bash
docker-compose run topo-lufo
```

- Move generated tiles from `/mnt/tiles/lufo_rd_cache_EPSG28992/` to: `/mnt/tiles/lufo<YEAR>_rd_cache_EPSG28992/`

- Upload the tiles to the objectstore using rclone

```bash
rclone sync lufo2018_rd_cache_EPSG28992 tilesacc:/ -vvv --transfers=20 --checkers=20
rclone sync lufo2018_rd_cache_EPSG28992 tiles:/ -vvv --transfers=20 --checkers=20
```

- Upload pyramid directory to objectstore

## Support

If we need help with the mapserver or mapproxy. We can contact the following person:

Edward Mac Gillavry
webmapper.net
