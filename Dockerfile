# Mapserver for Docker
FROM ubuntu:14.04.3
MAINTAINER datapunt@amsterdam.nl

# Update and upgrade system
RUN apt-get -qq update --fix-missing && apt-get -qq --yes upgrade
# Install Python and uwsgi
RUN apt-get install -y python-imaging python-yaml libproj0 libgeos-dev python-lxml python-shapely python-pip pwgen uwsgi uwsgi-plugin-python git
RUN pip install MapProxy==1.8.0

# Mapproxy content and config
RUN mkdir -p /app
COPY docker_files/* /app/
COPY *.yaml /app/
WORKDIR /app/
RUN mapproxy-util create -t wsgi-app --force -f mapproxy.yaml config.py

EXPOSE 8080

CMD /app/docker-entrypoint.sh
