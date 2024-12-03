#!/bin/bash

redis-server --daemonize yes

# install and set wordpress if this is first build
if [ ! -e '/var/www/html/wp-config.php' ]; then
	mkdir -p /var/www/html/
	
	chown -R www-data:www-data /var/www/html
	chmod -R 755 /var/www/html

	chown -R ${FTP_GROUP}:${FTP_USER} /var/www/html

	cd /var/www/html
	
	wp core download --allow-root  
	wp config create --allow-root --dbname=$WORDPRESS_DB_NAME \
	--dbuser=$WORDPRESS_DB_USER --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=$MARIADB_HOST
	wp core install --allow-root --url='https://localhost' \
	--title='inception' --admin_user=polarbear --admin_password=polarbear \
	--admin_email=polarbear@student.42seoul.kr

	# add admin user and normal user
	wp user create --allow-root sihong sihong@student.42seoul.kr --role=author --user_pass=sihong

	# install and activate redis object cache plugin
	wp plugin install --allow-root redis-cache
	sed -i "93a\\
// adjust Redis host and port if necessary\\
define( 'WP_REDIS_HOST', '127.0.0.1' );\\
define( 'WP_REDIS_PORT', 6379 );\\
\\
// change the prefix and database for each site to avoid cache data collisions\\
define( 'WP_REDIS_PREFIX', 'my-moms-site' );\\
define( 'WP_REDIS_DATABASE', 0 ); // 0-15\\
\\
// reasonable connection and read+write timeouts\\
define( 'WP_REDIS_TIMEOUT', 1 );\\
define( 'WP_REDIS_READ_TIMEOUT', 1 );\\
\\
define( 'FTP_USER', '${FTPUSER}' );\\
define( 'FTP_PASS', '${FTPPASS}' );\\
define( 'FTP_HOST', 'vsftpd' );\\
define( 'FTP_SSL', false );\\
" /var/www/html/wp-config.php
	
	wp plugin activate --allow-root redis-cache
	wp redis --allow-root enable

	# bonus part(set Adminer)
	wget https://www.adminer.org/latest.php -O adminer.php
fi

exec /usr/sbin/php-fpm8.2 --nodaemonize
