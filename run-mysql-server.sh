#!/bin/bash

echo "Starting MYSQL server instance!"

docker run --name lighty-mysqlserver \
  -h lighty-mysqlserver \
  -e MYSQL_ROOT_PASSWORD=toor -e MYSQL_DATABASE=lighttpd \
  -d mysql:latest

echo "|  "
echo "'--> Port 3306 will be exposed."
