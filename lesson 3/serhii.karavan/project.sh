#!/bin/bash

docker network create bridge-network

docker run --rm -d --net bridge-network --name dbpg -e POSTGRES_PASSWORD=123456 postgres:9.6.5
docker run --rm -d --net bridge-network --name my-redis redis
docker run -it --rm --net bridge-network --name my-ruby-script -p 9000:4567 -e DB=postgresql://postgres:123456@dbpg:5432 -e CACHE=redis://my-redis:6379 -v "$(pwd)":/app ruby:2.6.0 ruby /app/server.rb
