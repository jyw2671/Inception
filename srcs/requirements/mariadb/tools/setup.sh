#!/bin/bash

if [ ! -d /var/lib/mysql/${WP_DB_NAME} ]; then
    # mysql setting
    service mysql start
    mysql -e "CREATE DATABASE IF NOT EXISTS ${WP_DB_NAME} DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci; \
    CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'; \
    GRANT ALL ON ${WP_DB_NAME}.* TO '${MYSQL_USER}'@'%'; \
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; \
    FLUSH PRIVILEGES;"
    mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown
fi

# service mysql stop
# exec foreground
exec mysqld_safe
