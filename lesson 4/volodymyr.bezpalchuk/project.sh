#!/bin/bash

DB_CONTAINER=postgresdb
DB_NAME=postgres
DB_USER=postgres
DB_PASSWORD=dbpass
NETWORK=share-net
MAIN_DIR=${PWD}

DB="postgresql://${DB_USER}:${DB_PASSWORD}@${DB_CONTAINER}/${DB_NAME}"

CACHE="redis://redis:6379/1"

docker network create ${NETWORK}

docker run -d --rm --name psql --net ${NETWORK} -e POSTGRES_PASSWORD=${DB_PASSWORD} bezpalchukv/ma.devops.bezpalchuk.part2:psql

docker run -d --rm --name redis --net ${NETWORK} bezpalchukv/ma.devops.bezpalchuk.part2:redis

docker run -d --rm --name ruby-server -p 9000:4567 --net ${NETWORK} -e DB=${DB} -e CACHE=${CACHE} bezpalchukv/ma.devops.bezpalchuk.part2:ruby ruby /app/server.rb