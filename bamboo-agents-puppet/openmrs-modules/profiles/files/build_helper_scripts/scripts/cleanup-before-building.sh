#!/bin/sh

echo "Stopping all docker containers except for moby/buildkit"
docker ps -a | grep -v "moby/buildkit" | awk 'NR>1 {print $1}' | xargs -r docker kill

echo "Removing all docker containers not used in the last 48 hours"
docker system prune -af --filter until=48h

echo "Removing all unused docker volumes except for m2-repo"
docker volume ls -q -f dangling=true | grep -v 'm2-repo' | xargs -r docker volume rm -f

echo "Removing SDK temp files"
rm -Rf /tmp/openmrs-sdk-*
