#!/bin/bash

export POSTGRES_HOST=ma-postgres
export POSTGRES_DB=db
export POSTGRES_USER=postgres
export POSTGRES_PASSWORD=postgrespasswd

export REDIS_HOST=ma-redis
export REDIS_PASSWORD=p4ssw0rd

export DB="postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}/${POSTGRES_DB}"

export CACHE="redis://:${REDIS_PASSWORD}@${REDIS_HOST}:6379/0"

cd ./docker

envsubst < ".env.tmpl" > ".env"

ln -s ../../server.rb ./ruby/server.rb

docker build -t ruby_srv:latest ./ruby

docker-compose stop
docker-compose run -d 

rm .env