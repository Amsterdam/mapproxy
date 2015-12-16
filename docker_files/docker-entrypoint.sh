#!/usr/bin/env bash

set -e
set -u

echo Starting server
uwsgi --ini uwsgi.ini

#mapproxy-seed /srv/mapproxy/seed.yaml -f /srv/mapproxy/mapproxy.yaml --seed=topo_rd
#mapproxy-seed /srv/mapproxy/seed.yaml -f /srv/mapproxy/mapproxy.yaml --seed=topo_rd_detail
#mapproxy-seed /srv/mapproxy/seed.yaml -f /srv/mapproxy/mapproxy.yaml --seed=topo_rd_detail_plus
#mapproxy-seed /srv/mapproxy/seed.yaml -f /srv/mapproxy/mapproxy.yaml --seed=lufo2015_rd
#mapproxy-seed /srv/mapproxy/seed.yaml -f /srv/mapproxy/mapproxy.yaml --seed=lufo2015_rd_detail
#mapproxy-seed /srv/mapproxy/seed.yaml -f /srv/mapproxy/mapproxy.yaml --seed=lufo2015_rd_detail_plus
