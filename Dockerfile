FROM python:3.7-bullseye
LABEL maintainer="datapunt@amsterdam.nl"

EXPOSE 8000

ARG OS_URL
ENV OS_URL=$OS_URL

RUN adduser --system datapunt
WORKDIR /app

RUN chown datapunt -R /app

COPY requirements.txt /app/
RUN pip install -r requirements.txt

COPY src/* /app/
COPY docker-entrypoint.sh /bin

RUN pip install MapProxy==1.13.1

USER datapunt

CMD /bin/docker-entrypoint.sh
