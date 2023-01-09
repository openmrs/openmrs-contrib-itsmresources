#!/bin/sh

echo "Stopping docker containers except for moby/buildkit"
docker ps -a | grep -v "moby/buildkit" | awk 'NR>1 {print $1}' | xargs docker kill

echo "Removing all docker containers not used in the last 48 hours"
docker system prune -af --filter until=48h

echo "Removing all unused docker volumes except for m2-repo"
docker volume ls -q | grep -v 'm2-repo' | xargs docker volume rm -f
