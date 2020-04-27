FROM debian:10

MAINTAINER pohl <pohl@student.42.fr>

ADD /srcs/db.sql /tmp/

RUN apt-get update && apt-get -y upgrade \
	&& apt-get install -y \
		vim \
		wget \
		nginx \
		mariadb-server \
		unzip \
		php-mysql \
		php-fpm \
		php-cli \
	&& wget -O wordpress.zip https://wordpress.org/latest.zip \
	&& wget -O phpMyAdmin.tar.gz https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz

RUN mkdir -p /var/www/html /var/www/info \
	&& unzip wordpress.zip -d /var/www/ \
	&& tar xvf phpMyAdmin.tar.gz \
	&& mv phpMyAdmin-4.9.0.1-all-languages /var/www/phpmyadmin \
	&& rm wordpress.zip phpMyAdmin.tar.gz \
	&& chown -R $USER:$USER /var/www/* \
	&& chown -R www-data:www-data /var/www/* \
	&& chmod -R 755 /var/www/* \
	&& service mysql start \
	&& mysql -u root --password= < /tmp/db.sql \
	&& mkdir ~/mkcert && cd ~/mkcert \
  && wget https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64 \
  && mv mkcert-v1.1.2-linux-amd64 mkcert && chmod +x mkcert \
	&& ./mkcert -install && ./mkcert localhost 

ADD /srcs/localhost /etc/nginx/sites-available/localhost
ADD /srcs/info.php /var/www/info/info.php
ADD /srcs/wp-config.php /var/www/wordpress/wp-config.php
ADD /srcs/config.inc.php /var/www/phpmyadmin/config.inc.php
ADD /srcs/index.sh /index.sh
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/ && chmod +x /index.sh

EXPOSE 80
EXPOSE 443

CMD service mysql start \
	&& service php7.3-fpm start \
	&& bash /index.sh \
	&& nginx -g 'daemon off;'
