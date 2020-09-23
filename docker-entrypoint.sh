#!/usr/bin/env bash

set -e
set -u

# Replace actual location of the mapserver depending on the environment
sed -i 's#OS_URL_REPLACE#'"$OS_URL"'#g' /app/mapproxy.yaml

echo Create start script
mapproxy-util create -t wsgi-app -f /app/mapproxy.yaml --force /app/app.py

echo Starting server
uwsgi --wsgi-file /app/app.py --wsgi-disable-file-wrapper
