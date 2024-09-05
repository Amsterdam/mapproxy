FROM python:3.9-bullseye
LABEL maintainer="datapunt@amsterdam.nl"

EXPOSE 8000

ARG OS_URL
ENV OS_URL=$OS_URL

RUN adduser --system --uid 999 --group datapunt
RUN groupmod -o -g 999 datapunt

WORKDIR /app

RUN chown datapunt -R /app

COPY requirements.txt /app/
RUN pip install -r requirements.txt

COPY src/* /app/
COPY log.ini /app/log.ini
COPY docker-entrypoint.sh /bin

RUN pip install MapProxy==1.16.0

USER datapunt

CMD /bin/docker-entrypoint.sh
