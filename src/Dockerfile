FROM amsterdam/docker_python:latest
MAINTAINER datapunt@amsterdam.nl

EXPOSE 8000

RUN adduser --system datapunt

WORKDIR /app

COPY . /app/

RUN pip install MapProxy==1.10.0
USER datapunt

CMD uwsgi

