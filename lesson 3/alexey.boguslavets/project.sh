#!/bin/bash

NETWORK=alex_network
PG_USER=pguser
PG_PASSWORD=pgpass
PG_HOST=pg
PG_NAME=postgres

DB="postgresql://${PG_USER}:${PG_PASSWORD}@${PG_HOST}"
CACHE="redis://redis:6379/0"

docker network create ${NETWORK}

docker run --rm -d --net ${NETWORK} --name alex_postgres -e POSTGRES_PASSWORD=${PG_PASSWORD} postgres:9.6.5-alpine
docker run --rm -d --net ${NETWORK} --name alex_redis redis:4-alpine
docker run --rm --net ${NETWORK} -p 9000:4567 --name alex_ruby -e DB=${DB} -e CACHE=${CACHE} -v /home/alex/devops-course-2020/lesson\ 3/:/usr/src/app/ -w /usr/src/app ruby:2.6.0 ruby server.rb
