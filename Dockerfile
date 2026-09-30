FROM python:3.14-trixie
LABEL maintainer="datapunt@amsterdam.nl"

EXPOSE 8000

# build-time inputs (EXTRA_ARG* are what the k8s pipeline passes)
ARG EXTRA_ARG1
# EXTRA_ARG2 is the env's own mapserver (pipeline MAPS_URL); deliberately not used for seeding
ARG EXTRA_ARG2
# mapserver to seed from: always the o mapserver, in every env (test's mapserver has no data).
# override with --build-arg MAPSERVER_URL=...; https://host, host and host/tiled all work,
# all are normalized below to https://host
ARG MAPSERVER_URL=https://map.data-o.azure.amsterdam.nl

# Acceptance Tiles as default
ENV OS_URL=${EXTRA_ARG1:-t1.acc.data.amsterdam.nl} \
    MAPSERVER_URL=${MAPSERVER_URL}

RUN adduser --system --uid 999 --group datapunt
RUN groupmod -o -g 999 datapunt

RUN mkdir -p /tmp && chown datapunt:datapunt /tmp
RUN mkdir -p /app && chown datapunt:datapunt /app
WORKDIR /app

COPY requirements.txt /app/
RUN pip install -r requirements.txt

COPY --chown=datapunt:datapunt src/ /app/

RUN if [ -n "$MAPSERVER_URL" ] ; then \
        url="${MAPSERVER_URL%/}"; url="${url%/tiled}"; \
        case "$url" in http://*|https://*) ;; *) url="https://$url" ;; esac; \
        sed -i 's#MAPSERVER_URL_REPLACE#'"$url"'#g' /app/mapproxy-seed.yaml; fi && \
    if [ -n "$OS_URL" ]; then sed -i "s#OS_URL_REPLACE#${OS_URL}#g" /app/mapproxy.yaml ; fi

COPY log.ini /app/log.ini

RUN pip install MapProxy==7.0.0 # mapproxy>7 --> ogcapi support
RUN pip install appinsights
RUN mapproxy-util create -t wsgi-app -f /app/mapproxy.yaml --force /app/app.py
RUN printf '%s\n' \
'from logging.config import fileConfig' \
'from applicationinsights.requests import WSGIApplication' \
'import os' \
'fileConfig("/app/log.ini", {"here": os.path.dirname(__file__)})' \
'APPLICATIONINSIGHTS_INSTRUMENTATION_KEY = os.getenv("APPLICATIONINSIGHTS_INSTRUMENTATION_KEY", "")' \
'common_properties = { ' \
'    "service": "MapProxy",' \
'}' \
'if APPLICATIONINSIGHTS_INSTRUMENTATION_KEY:' \
'    application = WSGIApplication(APPLICATIONINSIGHTS_INSTRUMENTATION_KEY, application, common_properties=common_properties)' \
>> /app/app.py

USER datapunt

# CMD /bin/docker-entrypoint.sh
CMD uwsgi --wsgi-file /app/app.py --wsgi-disable-file-wrapper