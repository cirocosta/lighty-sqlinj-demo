echo "Starting MYSQL server!"
docker run --name mysqlserver -e MYSQL_ROOT_PASSWORD=toor -d mysql:latest
