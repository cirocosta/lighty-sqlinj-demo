#!/bin/bash

DOCKER_IMAGE=lighttpd-vuln

if [[ "$(docker images -q $DOCKER_IMAGE 2> /dev/null)" == "" ]]; then
  echo "Error:"
  echo "  The image $DOCKER_IMAGE must be built first."
  echo "  Run 'run-build-images.sh' first and then re-run 'run-vuln-lighttpd.sh'"
  exit 1
fi

echo "Creating 'vulnerable server' image"
echo "| "
echo "+---> port 80 will be exposed"
docker run -it --name lighty-vulnerable \
  -h lighty-vulnerable \
  --link lighty-mysqlserver:mysql -d lighttpd-vuln
