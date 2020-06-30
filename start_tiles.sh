#!/bin/sh

set -e
set -u

DIR="$(dirname $0)"

dc() {
	docker-compose -p mapproxy -f ${DIR}/docker-compose-tiles.yml $*
}

trap 'dc kill ; dc rm -f' EXIT

echo "Kill"
dc kill
echo "Remove"
dc rm -f
echo "Stop"
# clean environment
dc down --remove-orphans

# create dirs
echo "Create dirs"
mkdir -p /mnt/tiles/
chmod 755 /mnt/tiles/
echo "Cleanup old cache $1_cache_EPSG28992"
rm -rf "/mnt/tiles/topo_$1_cache_EPSG28992/"

echo "Build"
# generate geojson
dc build
dc run topo_$1
