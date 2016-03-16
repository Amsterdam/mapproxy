#!/usr/bin/env bash

mapproxy-seed /app/seed.yaml -f /app/mapproxy.yaml --seed=topo_rd
## && mapproxy-seed /app/seed.yaml -f /app/mapproxy.yaml --seed=topo_rd_detail