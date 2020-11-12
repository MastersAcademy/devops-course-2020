docker network create main6
docker run -d -it --rm --name postgres postgres:9.6.5
docker network connect main6 postgres
docker run -d -it --rm --name redis redis
docker network connect main6 redis

docker run --network main6 -it -p 9000:4567 -e "DB=postgres://postgres@postgres:5432/postgres" -e "CACHE=redis://redis:6379" -v "/home/nataly/devops-course-2020/lesson 3":/home/app/myserver ruby:2.6.0 bash -c 'ruby /home/app/myserver/server.rb'

