#!/bin/bash



### Configs
PG_NAME=postgres_devops3
REDIS_NAME=redis_devops3
RUBY_NAME=ruby_devops3

PG_HOST=postgres
PG_DB=db
PG_USER=ruby_test
PG_PASSWORD=super_secret

REDIS_HOST=redis
REDIS_PORT=6379

EXPOSE_PORT=9000

PROJECT_DIR="${PWD}/../"

DOCKER_NETWORK=devops3

# Database commands
DB="postgresql://${PG_USER}:${PG_PASSWORD}@${PG_HOST}/${PG_DB}"
CACHE="redis://${REDIS_HOST}:${REDIS_PORT}/1"



### Cleanup
echo ""
echo "# Stoping all images..."
echo ""

docker stop ${PG_NAME} && \
docker stop ${REDIS_NAME} &&
docker stop ${RUBY_NAME}

echo ${DB}
echo ${CACHE}


### Scripts
echo ""
echo "# Creating network..."
echo ""

docker network create ${DOCKER_NETWORK}

# Postgres
echo ""
echo "# Running packages..."
echo ""

docker run --rm -d \
  --name ${PG_NAME} \
  --net ${DOCKER_NETWORK} \
  -e POSTGRES_DB=${PG_DB} \
  -e POSTGRES_USER=${PG_USER} \
  -e POSTGRES_PASSWORD=${PG_PASS} \
  postgres:9.6.5-alpine

# Redis
docker run --rm -d \
  --name ${REDIS_NAME} \
  --net ${DOCKER_NETWORK} \
  redis

# Ruby
docker run --rm -d \
  --name ${RUBY_NAME} \
  --net ${DOCKER_NETWORK} \
  -e DB=${DB} \
  -e CACHE=${CACHE} \
  -p ${EXPOSE_PORT}:4567 \
  --mount "${PROJECT_DIR}":/app \
  ruby:2.6.0 \
  ruby ./app/server.rb
