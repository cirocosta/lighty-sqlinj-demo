#!/bin/bash

DOCKER_IMAGE=lighty
PROJECT_ROOT_DIR="$(dirname "$0")/.."

if [[ "$(docker images -q $DOCKER_IMAGE 2> /dev/null)" == "" ]]; then
  echo "Building general image" 
  docker build -t $DOCKER_IMAGE $PROJECT_ROOT_DIR
else
  echo "General image has already been built."
  echo "Image name: $DOCKER_IMAGE"
  exit 1
fi

cat << EOF
  To properly instantiate a Docker container based
  on the '$DOCKER_IMAGE' image, run 
  './create-lighty-container <container_name>' 
EOF

