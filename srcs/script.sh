#!/bin/bash

apt update
apt upgrade

apt install -y nginx mariadb-server mariadb-client php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline
service nginx start
service mysql start
service php7.3-fpm start
rm /etc/nginx/sites-enabled/default

