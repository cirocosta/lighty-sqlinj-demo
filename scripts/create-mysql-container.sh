#!/bin/bash

DOCKER_MYSQL=lighty-mysqlserver
DATABASE_NAME=lighttpd
MYSQL_IMAGE=mysql:latest
SCRIPTS_DIR="$(dirname "$0")"


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

if [[ $? -eq 0 ]]; then

  docker cp $SCRIPTS_DIR/db-init.sql $DOCKER_MYSQL:/db-init.sql
  docker exec $DOCKER_MYSQL "bash" "-c" "mysql -u root -ptoor lighttpd < /db-init.sql"
  echo "  | "
  echo "  +---> port 3306 will be exposed"
else
  echo ":("
  exit 1
fi
