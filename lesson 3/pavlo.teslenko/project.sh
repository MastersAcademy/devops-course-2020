docker network create net_1

docker run --rm -d --name postgres_test --net net_1 -e POSTGRES_PASSWORD=password postgres:9.6.5

docker run -d --name redis_test --net net_1 -e REDIS_PASSWORD=password redis redis-server --requirepass password

docker run -it --rm --name ruby_test --net net_1 -p 9000:4567 -e DB="postgresql://postgres:password@postgres_test:5432" -e CACHE="redis://:password@redis_test:6379" -v /home/paul/projects/devops-course-2020/lesson\ 3/:/my_app ruby:2.6.0 ruby /my_app/server.rb




