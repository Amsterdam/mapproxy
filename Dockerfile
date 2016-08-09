FROM python:2.7
MAINTAINER datapunt.ois@amsterdam.nl

RUN apt-get update \
    && apt-get install -y \
        python-imaging \
        python-yaml \
        libproj0 \
        libgeos-dev \
        python-lxml \
        python-shapely \
        python-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && pip install MapProxy==1.9.0 \
    && mkdir /app

COPY *.yaml /app/
COPY *.sh /usr/bin/
RUN chmod 755 /usr/bin/*.sh
