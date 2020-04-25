#!/bin/bash

state=$(grep '\(autoindex on\|autoindex off\)' /etc/nginx/sites-enabled/localhost)
echo "current state: $state"

printf "Do you want to change it? (on/off)"
read -r new_state

case "$new_state" in
	"on")
		sed -i 's/autoindex off/autoindex on/' /etc/nginx/sites-enabled/localhost
		service nginx restart
		;;
	"off")
		sed -i 's/autoindex on/autoindex off/' /etc/nginx/sites-enabled/localhost
		service nginx restart
		;;
	*)
		echo "$new_state is not a valid input, didn't change state"
		;;
esac
