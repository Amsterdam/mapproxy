FROM python:3.11-trixie
LABEL maintainer="datapunt@amsterdam.nl"

EXPOSE 8000

ARG OS_URL
ENV OS_URL=$OS_URL
ARG MAPSERVER_URL
ENV MAPSERVER_URL=$MAPSERVER_URL

RUN adduser --system --uid 999 --group datapunt
RUN groupmod -o -g 999 datapunt

WORKDIR /app

RUN chown datapunt -R /app

COPY requirements.txt /app/
RUN pip install -r requirements.txt

COPY src/* /app/

RUN if [ ! -z "$MAPSERVER_URL" ] ; then sed -i 's#MAPSERVER_URL_REPLACE#'"$MAPSERVER_URL"'#g' /app/mapproxy-seed.yaml; fi

COPY log.ini /app/log.ini
COPY docker-entrypoint.sh /bin

RUN pip install MapProxy==3.1.1

USER datapunt

CMD /bin/docker-entrypoint.sh
