#!/bin/bash

docker container rm srv
docker build -t test .
docker container run --name srv -p 80:80 -p 443:443 -it test
