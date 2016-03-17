#!/usr/bin/env bash

mapproxy-seed -c 6 -s /app/seed.yaml -f /app/mapproxy.yaml --seed=topo_rd && mapproxy-seed -c 6 -s /app/seed.yaml -f /app/mapproxy.yaml --seed=topo_rd_detail