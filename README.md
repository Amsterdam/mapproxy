# atlas_mapproxy

This project contains all the mapproxy files for the Atlas project.

To Run this as DEPLOY user: 

    nohup mapproxy-seed /srv/mapproxy/seed.yaml -f /srv/mapproxy/mapproxy.yaml --seed={insert-seed-task-name} &

seed.yaml - Caching configuratie
mapproxy.yaml - Mapproxy server config

Then for Production run this as ROOT on the fileserver:

    nohup rsync -a --progress /mnt/mapproxy_tiles-acc/cache_data/topo_rd_cache_EPSG28992/* /mnt/mapproxy_tiles/cache_data/topo_rd_cache_EPSG28992/ &
    
    