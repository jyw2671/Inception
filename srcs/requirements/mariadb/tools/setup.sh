#!/bin/bash

# create DATABASE
service mysql start
mysql -e "CREATE DATABASE IF NOT EXISTS ${WP_DB_NAME}; \
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'; \
GRANT ALL ON ${WP_DB_NAME}.* TO '${MYSQL_USER}'@'%'; \
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; \
FLUSH PRIVILEGES;"

# exec foreground
service mysql stop
exec mysqld_safe
