#!/bin/bash

DOCKER_MYSQL=lighty-mysqlserver
DATABASE_NAME=lighttpd
MYSQL_IMAGE=mysql:latest


if [[ "$(docker ps -a --filter 'name=lighty-mysqlserver' --format='{{ .Names }}' 2> /dev/null)" != "" ]]; then
  echo "--------"
  echo "The container '$DOCKER_MYSQL' already exists." 
  echo "If it is not Up, simply run 'docker start $DOCKER_MYSQL'." 
  echo "  Instance: $(docker ps -a --filter 'name=lighty-mysqlserver' --format='{{ .Names }} | {{ .Status }}')"
  exit 1
fi

echo "Starting MYSQL server instance!"

docker run --name $DOCKER_MYSQL \
  -h $DOCKER_MYSQL \
  -e MYSQL_ROOT_PASSWORD=toor -e MYSQL_DATABASE=$DATABASE_NAME \
  -d $MYSQL_IMAGE

echo "  |  "
echo "  '--> Port 3306 will be exposed."
