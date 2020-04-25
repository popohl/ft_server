#!/bin/bash

docker container rm srv
docker build -t test .
#docker container run --name srv -p "$public_http":80 -p "$public_http":443 -it test
docker container run --name srv -P -it test
docker container ls --all
