#!/bin/bash

DOCKER_IMAGE=lighty
DOCKER_MYSQL=lighty-mysqlserver

show_help() {
cat << EOF
Usage: ./create-lighty-container <name>

Params:
  name    name of the container for the 
          '$DOCKER_IMAGE' image resulting in
          a container named 'lighty-{NAME}'.
EOF
}

if [ $# -eq 0 ]; then
    show_help
    exit 1
fi

NAME="lighty-$1"

echo "Creating lighty container..."

if [[ "$(docker images -q $DOCKER_IMAGE 2> /dev/null)" == "" ]]; then
  echo "Error:"
  echo "  The image $DOCKER_IMAGE must be built first."
  echo "  Run 'run-build-images.sh' first and then re-run 'create-lighty-container.sh $NAME'"
  exit 1
fi

if [[ "$(docker ps -a --filter 'name=$DOCKER_MYSQL' --format='{{ .Names }}' 2> /dev/null)" == "" ]]; then
  echo "The container '$DOCKER_MYSQL' couldn't be found." 
  echo "You must to have a mysqlserver container named $DOCKER_MYSQL running." 
  echo "Run './create-mysql-container' to create it." 
  exit 1
fi

docker run -it --name $NAME \
  -h $NAME \
  --link $DOCKER_MYSQL:mysql -d $DOCKER_IMAGE

echo "  | "
echo "  +---> port 80 will be exposed"

