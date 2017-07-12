FROM amsterdam/docker_python:latest
MAINTAINER datapunt@amsterdam.nl

EXPOSE 8000

RUN adduser --system datapunt

WORKDIR /app

COPY . /app/

RUN pip install MapProxy==1.10.0

RUN mapproxy-util create -t wsgi-app -f /app/mapproxy.yaml /app/app.py

USER datapunt
CMD uwsgi --wsgi-file /app/app.py --master --enable-threads --processes 4 --threads 2
