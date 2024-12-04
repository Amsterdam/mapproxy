#!/usr/bin/env bash

set -e
set -u

# Replace actual location of the Object Store depending on the environment
[[ ! -z "$OS_URL" ]] && sed -i 's#OS_URL_REPLACE#'"$OS_URL"'#g' /app/mapproxy.yaml
# Replace actual location of the MapServer depending on the environment
[[ ! -z "$MAPSERVER_URL" ]] && sed -i 's#MAPSERVER_URL_REPLACE#'"$MAPSERVER_URL"'#g' /app/mapproxy-seed.yaml

echo Create start script
mapproxy-util create -t wsgi-app -f /app/mapproxy.yaml --force /app/app.py

cat >> /app/app.py <<- EOM
from logging.config import fileConfig
import os.path
fileConfig("/app/log.ini", {"here": os.path.dirname(__file__)})
EOM

echo Starting server
uwsgi --wsgi-file /app/app.py --wsgi-disable-file-wrapper
