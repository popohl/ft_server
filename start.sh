#!/bin/bash

docker build -t ft_server .
case "$1" in
	"it") docker container run -it --name srv -p 80:80 -p 443:443 --rm ft_server ;;
	"off") docker container run -d --name srv -p 80:80 -p 443:443 --rm -e INDEX='off' ft_server ;;
	*) docker container run -d --name srv -p 80:80 -p 443:443 --rm ft_server ;;
esac
sleep 3
docker container ls --all
