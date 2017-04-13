# atlas_mapproxy

This project contains all the mapproxy files for the Datapunt Map project.

To Run this:

    docker-compose build
    
    docker-compose run topo-kbk

seed.yaml - Caching configuratie
mapproxy.yaml - Mapproxy server config

---------------------

Luchtfoto tegels
----------------

Creating a new Lufo year of tiles and service follow these steps:

1. Copy the aerial pictures (tif) to localhost
2. Run mapserver/lufopyramids.sh (see comments in file)
3. doso
4. Set the port in mapproxy.yaml to the port of the mapserver docker
5. Run mapproxy docker:

    docker-compose run topo-lufo
sudcd

6. Move generated tiles from cd  to: /mnt/tiles/lufo<YEAR>_rd_cache_EPSG28992/
7. Upload the tiles to the objectstore:


    lftp -e 'mirror --ignore-time --no-perms --no-umask --only-missing -R -p -v -P 10 /mnt/tiles/lufo<YEAR>_rd_cache_EPSG28992/ /tiles/lufo<YEAR>_rd_cache_EPSG28992/' ftp.objectstore.eu    
    
8. Upload pyramid directory to objectstore



---------------

version: '2.1'
services:
  upload:
#    build: ../../
    image: build.datapunt.amsterdam.nl:5000/datapunt/tileupload:${ENVIRONMENT}
    volumes:
      - ${SOURCE_PATH}:/app/data
    environment:
      - OS_CONTAINER=${OS_CONTAINER}
      - OS_USERNAME=${OS_USERNAME}
      - OS_PROJECT_NAME=${OS_PROJECT_NAME}
      - OS_TENANT_NAME=${OS_TENANT_NAME}
      - OS_AUTH_TYPE=password
      - OS_AUTH_URL=https://identity.stack.cloudvps.com/v2.0
      - OS_PASSWORD=${OS_PASSWORD}
    mem_limit: 14g
    command: >
      bash -c "cd /app/data/${OS_CONTAINER} && swift -s -q upload --changed --ignore-checksum --object-threads 10 ${OS_CONTAINER} ."
