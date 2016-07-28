# atlas_mapproxy

This project contains all the mapproxy files for the Atlas project.

To Run this:

    docker-compose build
    
    docker-compose run topo-kbk

seed.yaml - Caching configuratie
mapproxy.yaml - Mapproxy server config

Then for Production run this as ROOT on the fileserver:

    nohup rsync -a --progress /mnt/mapproxy_tiles-acc/cache_data/topo_rd_cache_EPSG28992/* /mnt/mapproxy_tiles/cache_data/topo_rd_cache_EPSG28992/ &
    
    