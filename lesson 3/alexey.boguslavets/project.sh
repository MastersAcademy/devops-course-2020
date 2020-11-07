#!/bin/bash

docker network create alex_network

docker run --rm -d -e POSTGRESS_PASSWORD=somepass -p 5432:5432 --net alex_network --name alex_postgres postgres:9.6.5
docker run --rm -d -e REDIS_PASSWORD=somepass -p 6379:6379 --net alex_network --name alex_redis redis redis-server --requirepass somepass
docker run -it --rm --net alex_network -p 9000:4567 -e DB=postgresql:somepass@alex_postgres:5432 -e CHACHE=redis://:somepass@alex_redis:6379/ -v /home/alex/devops-course-2020/lesson\ 3/:/usr/src/app/ -w /usr/src/app ruby:2.6.0 ruby server.rb
