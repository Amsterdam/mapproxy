#!/usr/bin/env bash

mapproxy-seed -c 6 -s /app/seed.yaml -f /app/mapproxy.yaml --seed=topo_google_kbk,topo_google_bgt
