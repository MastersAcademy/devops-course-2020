#!/bin/bash

export POSTGRES_HOST=ma-postgres
export POSTGRES_DB=db
export POSTGRES_USER=postgres
export POSTGRES_PASSWORD=postgrespasswd

export REDIS_HOST=ma-redis
export REDIS_PASSWORD=p4ssw0rd

export DB="postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}/${POSTGRES_DB}"

export CACHE="redis://:${REDIS_PASSWORD}@${REDIS_HOST}:6379/0"

rsync -r docker/ build/

mkdir -p build/src && cp ../server.rb build/src/

cd ./build

envsubst < ".env" > ".env.tmp" && mv .env.tmp .env

docker build -f ./ruby/Dockerfile -t ruby_srv:latest .

docker-compose down
docker-compose up -d 

cd ..
rm -r build/
