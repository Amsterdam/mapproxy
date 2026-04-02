FROM python:3.11-trixie
LABEL maintainer="datapunt@amsterdam.nl"

EXPOSE 8000

# build-time inputs
ARG EXTRA_ARG1
ARG EXTRA_ARG2

# Acceptance Tiles as default
ENV OS_URL=${EXTRA_ARG1:-t1.acc.data.amsterdam.nl} \
    MAPSERVER_URL=${EXTRA_ARG2:-map.data.amsterdam.nl}

RUN adduser --system --uid 999 --group datapunt
RUN groupmod -o -g 999 datapunt

WORKDIR /app

COPY requirements.txt /app/
RUN pip install -r requirements.txt

COPY --chown=datapunt:datapunt src/ /app/

RUN if [ -n "$MAPSERVER_URL" ] ; then sed -i 's#MAPSERVER_URL_REPLACE#'"$MAPSERVER_URL"'#g' /app/mapproxy-seed.yaml; fi && \
    if [ -n "$OS_URL" ]; then sed -i "s#OS_URL_REPLACE#${OS_URL}#g" /app/mapproxy.yaml ; fi

COPY log.ini /app/log.ini 

RUN pip install MapProxy==3.1.1
RUN mapproxy-util create -t wsgi-app -f /app/mapproxy.yaml --force /app/app.py
RUN printf '%s\n' \
'from logging.config import fileConfig' \
'import os.path' \
'fileConfig("/app/log.ini", {"here": os.path.dirname(__file__)})' \
>> /app/app.py

USER datapunt

# CMD /bin/docker-entrypoint.sh
CMD uwsgi --wsgi-file /app/app.py --wsgi-disable-file-wrapper