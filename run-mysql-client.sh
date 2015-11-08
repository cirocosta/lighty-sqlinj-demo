docker run -it --link mysqlserver:mysql --rm mysql \ 
  sh -c 'exec mysql \ 
    -h"$MYSQL_PORT_3306_TCP_ADDR" \
    -P"$MYSQL_PORT_3306_TCP_PORT" \
    -u root -p"toor"'

