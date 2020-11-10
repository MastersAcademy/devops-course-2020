#!/bin/bash

PG_HOST=pg_host
PG_DB=pgdb
PG_USER=pguser
PG_PASS=pgpass

REDIS_HOST=redis_host
REDIS_PASS=redis_pass

docker network create lesson_3



docker run --rm -d \
    --net lesson_3 \
    -e POSTGRES_DB=${PG_DB} \
    -e POSTGRES_USER=${PG_USER} \
    -e POSTGRES_PASSWORD=${PG_PASS} \
    -v $HOME/docker/volumes/postgres:/var/lib/postgresql/data \
    --name ${PG_HOST} \
    postgres:9.6.5

docker run --rm -d \
    --net lesson_3 \
    --name ${REDIS_HOST} \
    redis

docker run --rm -d \
    -p 9000:4567 \
    --net lesson_3 \
    -e DB="postgres://${PG_USER}:${PG_PASS}@${PG_HOST}/${PG_DB}" \
    -e CACHE="redis://${REDIS_HOST}:6379/0" \
    -v "$PWD"/../:/app/ \
    --name ruby_server \
    ruby:2.6.0 \
    ruby /app/server.rb


