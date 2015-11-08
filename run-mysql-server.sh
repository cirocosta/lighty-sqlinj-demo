#!/bin/bash

echo "Starting MYSQL server instance!"
echo "|  "
echo "+--> Port 3306 will be exposed."
docker run --name mysqlserver \
  -e MYSQL_ROOT_PASSWORD=toor \
  -d mysql:latest
