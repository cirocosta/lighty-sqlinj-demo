#!/bin/bash

echo "Docker container ip Addresses:"
for container in $(docker ps --filter="name=lighty" --format="{{.Names}}"); do
  echo " - $container: $(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $container)"
done

