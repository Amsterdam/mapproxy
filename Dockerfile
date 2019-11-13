FROM amsterdam/python3.6
MAINTAINER datapunt@amsterdam.nl

EXPOSE 8000

ARG OS_URL
ENV OS_URL=$OS_URL

RUN adduser --system datapunt

RUN chown datapunt -R /app
WORKDIR /app

COPY src/* /app/
COPY docker-entrypoint.sh /bin

RUN pip install MapProxy==1.12.0

USER datapunt

CMD /bin/docker-entrypoint.sh
