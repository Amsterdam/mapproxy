# mapproxy

This project contains all the mapproxy files for the Datapunt Map project.

To Run this:

    docker-compose build
    
    docker-compose run topo-kbk

seed.yaml - Caching configuratie
mapproxy.yaml - Mapproxy server config

---------------------


# Tiles Job

Project location: https://ci.data.amsterdam.nl/job/Tiles/

Do not change the following value 1, otherwise the mapserver will crash. ( apache2 - mapserver ) 
The mapserver is tuned (project mapserver - branch basis) 

mapproxy-seed -c 1 -s /app/seed.yaml -f /app/mapproxy.yaml --seed=topo_rd_kbk,topo_rd_bgt

You can start the following job 

This job is starting a internal webserver( apache2 > mapserver > and is generating on de build slaves the new images. The script is copying the tiles to /mnt/tiles. after the build process is done. The tiles will be uploaded to the objectstore in the next job. 

# Global settings

meta_size: If you set this to a higher value for example 8 x 8 the internal mapserver is crashing. 
mea_buffer: do not change this. 

```
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

Luchtfoto tegels
----------------

Creating a new Lufo year of tiles and service follow these steps:

- Copy the aerial pictures (tif) to localhost
- Run mapserver/lufopyramids.sh (see comments in file)
- Start mapserver docker
- Run mapproxy docker: 
```
docker-compose run topo-lufo
```
- Move generated tiles from /mnt/tiles/lufo_rd_cache_EPSG28992/ to: /mnt/tiles/lufo<YEAR>_rd_cache_EPSG28992/
- Upload the tiles to the objectstore using rclone
```
rclone sync lufo2018_rd_cache_EPSG28992 tilesacc:/ -vvv --transfers=20 --checkers=20
rclone sync lufo2018_rd_cache_EPSG28992 tiles:/ -vvv --transfers=20 --checkers=20
```
- Upload pyramid directory to objectstore
    
 # Support
 
 If we need help with the mapserver or mapproxy. We can contact the following person:
 
Edward Mac Gillavry
webmapper.net

