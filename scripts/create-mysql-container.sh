#!/bin/bash

DOCKER_MYSQL=lighty-mysqlserver
DATABASE_NAME=lighttpd
MYSQL_IMAGE=mysql:latest


if [[ "$(docker ps -a --filter 'name=$DOCKER_MYSQL' --format='{{ .Names }}' 2> /dev/null)" != "" ]]; then
  echo "The container '$DOCKER_MYSQL' already exists." 
  echo "If it is not running, simply run 'docker start $DOCKER_MYSQL'." 
  exit 1
fi

echo "Starting MYSQL server instance!"

docker run --name $DOCKER_MYSQL \
  -h $DOCKER_MYSQL \
  -e MYSQL_ROOT_PASSWORD=toor -e MYSQL_DATABASE=$DATABASE_NAME \
  -d $MYSQL_IMAGE

echo "  |  "
echo "  '--> Port 3306 will be exposed."
