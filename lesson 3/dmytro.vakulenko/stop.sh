PG_NAME=postgres_devops3
REDIS_NAME=redis_devops3
RUBY_NAME=ruby_devops3

docker stop ${PG_NAME} && \
docker stop ${REDIS_NAME} &&
docker stop ${RUBY_NAME}