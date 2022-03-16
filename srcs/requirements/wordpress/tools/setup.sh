#!/bin/bash

until mysql --host=mariadb --user=$MYSQL_USER --password=$MYSQL_PASSWORD -e '\c'; do
  echo >&2 "mariadb is unavailable - sleeping"
  sleep 1
done

if ! wp core is-installed --allow-root --path='/var/www/html'; then
	# wordpress setup
	cp -R /wordpress/* /var/www/html/
	rm /var/www/html/wp-config-sample.php
	cp wp-config.php /var/www/html/wp-config.php
	chown -R www-data:www-data /var/www/html

	# wordpress cli(command line interface) install
	wp core download --locale=ko_KR --allow-root --path='/var/www/html'
	wp core install --url=$DOMAIN_NAME --title='WP for inception' --admin_user=$MYSQL_USER\
		--admin_password=$MYSQL_PASSWORD --admin_email=$MYSQL_EMAIL --allow-root --path='/var/www/html/'

	# make wordpress user
	wp user create --allow-root $WP_USER_ID $WP_USER_EMAIL --user_pass=$WP_USER_PW --role=author --path='/var/www/html'
fi

# run wordpress foreground
service php7.3-fpm stop
exec php-fpm7.3 --nodaemonize
