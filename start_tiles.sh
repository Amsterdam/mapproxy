#!/bin/sh

set -e
set -u

DIR="$(dirname $0)"

dc() {
	# docker-compose pull
	docker-compose -p mapproxy -f ${DIR}/docker-compose.yml $*
}

trap 'dc kill ; dc rm -f' EXIT

echo "Kill"
dc kill
echo "Remove"
dc rm -f
echo "Stop"
# clean environment
dc down --remove-orphans

# start database
# dc up -d --force-recreate database
# Start mapserver
# dc up -d mapserver
# sleep 10

# create dirs
echo "Create dirs"
sudo mkdir -p /mnt/tiles
sudo chmod 755 /mnt/tiles
sudo rm -rf /mnt/tiles/*

# import basiskaart db
# dc exec -T database update-db.sh basiskaart
# dc exec -T database update-db.sh bag_v11


echo "Build"
# generate geojson
dc build
dc run topo_$1
