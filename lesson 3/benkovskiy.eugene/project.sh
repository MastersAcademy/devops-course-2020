#creating a new network
docker network create network_new

#run postgres DB on a created network
docker run --rm -d -e POSTGRES_PASSWORD=test123 --net network_new --name postgres_db postgres:9.6.5
#running local redis cache server
docker run --rm -d -e REDIS_PASSWORD=test123 --net network_new --name redis_srv redis redis-server --requirepass test123
#setting all together to a one network
docker run -it --rm --net network_new -p 9000:4567 -e DB=postgresql://postgres:test123@postgres_db:5432 -e CACHE=redis://:test123@redis_srv:6379/ -v /home/virtu03/Projects/devops-course-2020/lesson\ 3/:/app ruby:2.6.0 ruby /app/server.rb
