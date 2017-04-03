#!/bin/sh

set -e
set -u

DIR="$(dirname $0)"

dc() {
	docker-compose -p tileupload -f ${DIR}/docker-compose.yml $*
}

trap 'dc kill ; dc rm -f' EXIT

dc build
dc run --rm upload
