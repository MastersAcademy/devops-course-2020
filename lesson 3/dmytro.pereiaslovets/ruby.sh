#!/bin/bash

NET=local_ruby
APP=${PWD}

POSTGRE_DB=postgres
POSTGRE_USER=postgres
POSTGRE_PASSWORD=passwd

docker network create ${NET}

docker run -d --name postgre_db --net ${NET} -e POSTGRES_PASSWORD=${DB_PASSWORD} postgres:9.6.5-alpine &&
docker run -d --name redis_cache --net ${NET} redis:4-alpine &&
docker run -d --name ruby -p 127.0.0.1:9000:4567 --net ${NET} -e CACHE="redis://redis_cache:6379/" -e DB="postgresql://postgres:passwd@postgre_db/postgres" -v "${APP}"/:/app/ ruby:2.6.0 ruby /app/server.rb
