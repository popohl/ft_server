#!/bin/bash
# Description: This script disables autoindex if the environnement variable
# $INDEX is set to 'off', and enables it otherwise

case "$INDEX" in
	"off")
		sed -i 's/autoindex on/autoindex off/' /etc/nginx/sites-enabled/localhost
		echo "<head><meta http-equiv='refresh' content='0; URL=/wordpress/'></head>" > /var/www/index.html
		;;
	*)
		sed -i 's/autoindex off/autoindex on/' /etc/nginx/sites-enabled/localhost
		;;
esac
