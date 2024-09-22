#!/bin/bash

set -euv

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

# Docker is running with user 1001
log "Making sure private key private key is accessible by ldap docker user"
find /etc/letsencrypt/archive -name "priv*" | xargs chmod a+r
find /etc/letsencrypt/archive -name "priv*" | xargs ls -la


# Log the start of the script
log "Running post-renewal hook."

# Change to open ldap directory and restart using the docker-compose file there
for f in /root/docker/ldap*; do
    echo "Running docker compose recreate for $f"
    cd $f
    DOCKER_OUTPUT=$(docker-compose down && docker-compose up -d --force-recreate 2>&1)

    # Log the output of the docker command
    log "Docker command output: $DOCKER_OUTPUT"
done


# Log the completion of the script
log "Post-renewal hook completed."