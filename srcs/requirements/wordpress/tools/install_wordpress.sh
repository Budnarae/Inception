#!/bin/bash

apt update -y && apt upgrade -y
apt install -y php-fpm php-mysql php-redis redis-server curl wget

chmod 777 /usr/sbin/php-fpm8.2

# install wp cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp
