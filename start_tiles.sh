#!/bin/sh

set -e
set -u

DIR="$(dirname $0)"

dc() {
	docker compose pull
	docker compose -p mapproxy -f ${DIR}/compose-seed.yml $*
}

trap 'dc kill ; dc rm -f' EXIT

# clean environment
dc down

dc build
dc run topo_$1
