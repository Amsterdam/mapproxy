#!/bin/sh

set -e
set -u

DIR="$(dirname $0)"

dc() {
	docker-compose -p mapproxy -f ${DIR}/docker-compose.yml $*
}

trap 'dc kill ; dc rm -f' EXIT

 start database
dc up -d --force-recreate database
sleep 10

# create dirs
sudo mkdir -p /mnt/tiles
sudo chmod 755 /mnt/tiles

# import basiskaart db
dc exec -T database update-db.sh basiskaart
dc exec -T database update-db.sh atlas

# generate geojson
dc build
dc run topo_rd
dc run topo_rd_light
dc run topo_rd_zw
dc run topo_wm
dc run topo_wm_light
dc run topo_wm_zw