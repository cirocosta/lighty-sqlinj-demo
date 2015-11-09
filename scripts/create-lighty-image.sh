#!/bin/bash

DOCKER_IMAGE=lighty

if [[ "$(docker images -q $DOCKER_VULN_IMAGE 2> /dev/null)" == "" ]]; then
  echo "Building general image" 
  docker build -t $DOCKER_IMAGE ..
else
  echo "General image has already been built."
  echo "Image name: $DOCKER_VULN_IMAGE"
  exit 1
fi

cat << EOF
  To properly instantiate a Docker container based
  on the '$DOCKER_IMAGE' image, run 
  './create-lighty-container <container_name>' 
EOF
