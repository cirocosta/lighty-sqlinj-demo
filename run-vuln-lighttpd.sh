echo "Creating 'vulnerable server' image"
docker run -it --name vulnerable_server --link mysqlserver:mysql -d lighttpd-vuln
