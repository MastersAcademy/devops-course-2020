docker run -d -it --rm --name mypg postgres:9.6.5

docker run -d -it --rm --name myredis redis

docker run -it -p 9000:4567 --name myserver --link mypg:postgres --link myredis:redis -e "DB=postgres://postgres@postgres:5432/postgres" -e "CACHE=redis://redis:6379" -v "/home/nataly/devops-course-2020/lesson 3":/home/app/myserver ruby:2.6.0 bash -c 'ruby /home/app/myserver/server.rb'


