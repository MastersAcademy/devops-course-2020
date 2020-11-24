#!/bin/bash
#set -x

# apt update
# apt update
#  apt-get install -y \
#     apt-transport-https \
#     ca-certificates \
#     curl \
#     gnupg-agent \
#     software-properties-common
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# add-apt-repository \
#    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
#    $(lsb_release -cs) \
#    stable"


# apt update
# apt install -y docker-ce docker-ce-cli containerd.io
# usermod -aG docker moc-adm

# su moc-adm

git clone https://github.com/MastersAcademy/devops-course-2020.git
mv ./devops-course-2020/lesson\ 3/vendor/ ./
mv ./devops-course-2020/lesson\ 3/server.rb ./
rm -rf devops-course-2020
docker network create test_net
docker run --rm -d --name pg --net test_net -e POSTGRES_PASSWORD=pass postgres:9.6.5
docker run --rm -d --name redis --net test_net -e REDIS_PASSWORD=pass redis redis-server --requirepass pass
docker run -it --rm --name rb --net test_net -p 9000:4567 -e DB="postgresql://postgres:pass@pg:5432" -e CACHE="redis://:pass@redis:6379" -v "$PWD":/my_app ruby:2.6.0 ruby /my_app/server.rb