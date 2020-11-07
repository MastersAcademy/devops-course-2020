#!/bin/bash

docker network create alex_network

DB="postgresql://postgresql:somepass@alex_postgress:5432"
CACHE="redis://:somepass@0.0.0.0:6379/15"

docker run --rm -d --net alex_network -p 9000:4567 --name alex_ruby -e DB=postgresql:somepass@alex_postgres:5432 -e CHACHE=redis://:somepass@alex_redis:6379/ \
-v /home/alex/devops-course-2020/lesson\ 3/:/usr/src/app/ -w /usr/src/app ruby:2.6.0 ruby server.rb
docker run --rm -d --net alex_network -p 5432:5432 --name alex_postgres -e POSTGRESS_PASSWORD=somepass  postgres:9.6.5
docker run --rm -d --net alex_network -p 6379:6379 --name alex_redis -e REDIS_PASSWORD=somepass  redis redis-server --requirepass somepass