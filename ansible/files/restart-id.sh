#!/bin/bash

# This script stops, cleans and starts the openLDAP container after a letsencrypt certificate renewal.


# Define our log file
logfile=/var/log/letsencrypt/renew_hook.log

# Make sure the file exists and is writeable
touch $logfile
chmod 644 $logfile

# Define a function to log with a timestamp
log() {
    local msg="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $msg" >> $logfile
}

# Log the start of the script
log "Running post-renewal hook."

# Change to open ldap directory and restart using the docker-compose file there
cd /root/docker/ldap-stg/
DOCKER_OUTPUT=$(docker-compose down && docker-compose up -d --force-recreate 2>&1)

# Log the output of the docker command
log "Docker command output: $DOCKER_OUTPUT"

# Log the completion of the script
log "Post-renewal hook completed."