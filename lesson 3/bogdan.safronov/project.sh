docker create network_new

docker run --rm -d -e POSTGRES_PASSWORD=test12345 --net network_new --name postgres_db postgres:9.6.5
docker run --rm -d -e POSTGRES_PASSWORD=test12345 --net network_new --name redis_server redis redis-serv --requirepass test12345
docker run -it --rn --net network_new -p 9000:4567 -e DB=postgresql://postgrestest12345@postgres_db:5432 -e CACHE=redis://:test12345@redis_server:6379/ -v /home/Homework/03.11/devopse-course-2020/lesson \3/:app ruby:2.6.0 ruby /app/server.rb
