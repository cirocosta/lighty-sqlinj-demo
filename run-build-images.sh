#!/bin/bash

DOCKER_VULN_IMAGE=lighttpd-vuln
DOCKER_PATCHED_IMAGE=lighttpd-patched

DOCKERFILE_NAME=Dockerfile-vuln
if [[ "$(docker images -q $DOCKER_VULN_IMAGE 2> /dev/null)" == "" ]]; then
  echo "Building vulnerable image ..."
  mv ./$DOCKERFILE_NAME Dockerfile
  docker build -t lighttpd-vuln .
  mv ./Dockerfile $DOCKERFILE_NAME
else
  echo "Vulnerable image has already been built."
  echo "Image name: $DOCKER_VULN_IMAGE"
fi

# DOCKERFILE_NAME=Dockerfile-patched
# if [[ "$(docker images -q $DOCKER_PATCHED_IMAGE 2> /dev/null)" == "" ]]; then
#   echo "Building patched image ..."
#   mv ./Dockerfile-patched Dockerfile
#   docker build -t lighttpd-pathed .
#   mv ./Dockerfile Dockerfile-patched
# else
#   echo "Patched image has already been built."
#   echo "Image name: $DOCKER_PATCHED_IMAGE"
# fi

