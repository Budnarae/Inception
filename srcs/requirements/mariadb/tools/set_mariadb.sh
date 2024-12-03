#!/bin/bash

apt update -y && apt upgrade -y
apt install -y mariadb-server

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

cat << EOF > /create_database.sql
CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME} 
DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE USER IF NOT EXISTS ${WORDPRESS_DB_USER}@'%' 
IDENTIFIED BY "${WORDPRESS_DB_PASSWORD}";
GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO 
${WORDPRESS_DB_USER}@'%';
FLUSH PRIVILEGES;
EOF

mysqld --bootstrap --user=mysql --skip-grant-tables=false < create_database.sql

exec mysqld --console --user=mysql --bind-address=0.0.0.0
