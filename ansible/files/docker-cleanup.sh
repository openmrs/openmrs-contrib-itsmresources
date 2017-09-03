#!/bin/bash

set -e
set -u
set -x

docker container prune -f
docker image prune -a -f
docker network prune -f
