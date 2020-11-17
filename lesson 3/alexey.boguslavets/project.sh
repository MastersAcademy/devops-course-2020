#!/bin/bash

NETWORK=alex_network
DB_USER=postgres
DB_PASSWORD=passw0rd
DB_HOST=pgdb
DB_NAME=postgres
DB="postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}/${DB_NAME}"
CACHE="redis://password@redis:6379/1"

docker network create ${NETWORK}
docker run --rm -d --net ${NETWORK} --name ${DB_HOST} -e POSTGRES_PASSWORD=${DB_PASSWORD} postgres:9.6.5-alpine
docker run --rm -d --net ${NETWORK} --name redis redis:4-alpine
docker run --rm -it --net ${NETWORK} -p 9000:4567 --name ruby -e DB=${DB} -e CACHE=${CACHE} \
-v /home/alex/devops-course-2020/lesson\ 3/:/usr/src/app/ -w /usr/src/app ruby:2.6.0 ruby server.rb

# watch -n 1 "docker ps -a; echo; docker network ls; echo; docker volume ls; echo; docker image ls"