#!/bin/sh

set -e
set -u

DIR="$(dirname $0)"

dc() {
	docker-compose pull
	docker-compose -p mapproxy -f ${DIR}/docker-compose.yml $*
}

trap 'dc kill ; dc rm -f' EXIT

# clean environment
dc down

# start database
dc up -d --force-recreate database
# Start mapserver
dc up -d mapserver
sleep 10

# create dirs
sudo mkdir -p /mnt/tiles
sudo chmod 755 /mnt/tiles

# import basiskaart db
dc exec -T database update-db.sh basiskaart
dc exec -T database update-db.sh bag_v11


# generate geojson
dc build
echo "Copy indexes.sh"
docker cp ${DIR}/src/indexes.sh "$(dc ps -q database)":/tmp/indexes.sh
echo "Update database indexes"
dc exec -T database psql -U postgres -d basiskaart -f /tmp/indexes.sh

sudo rm -rf /mnt/tiles/topo_rd_cache_EPSG28992/
dc run topo_$1
