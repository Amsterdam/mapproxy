#!/bin/sh

set -e
set -u

DIR="$(dirname $0)"

dc() {
	docker-compose -p mapproxy -f ${DIR}/docker-compose.yml $*
}

#trap 'dc kill ; dc rm -f' EXIT

# start database
dc up -d --build database
sleep 10

# create dirs
sudo mkdir -p /mnt/tiles
sudo chmod 755 /mnt/tiles

# import basiskaart db
dc exec database update-db.sh basiskaart

# generate geojson
#dc run --rm topo_rd
dc run topo_rd