FROM amsterdam/docker_python:latest
MAINTAINER datapunt@amsterdam.nl

RUN apt-get update \
	&& apt-get install -y \
        python3-dev \
        python3-pip \
        libpq-dev \
        gdal-bin \
		postgresql-client \
		netcat \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /app/data

WORKDIR /app
COPY requirements.txt /app/
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . /app/
COPY .jenkins/import /.jenkins-import/
