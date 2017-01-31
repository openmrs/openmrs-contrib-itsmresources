#!/bin/bash
# Simple script to backup mongodb nightly
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_PATH=/var/backups/mongodb/${TIMESTAMP}

mkdir -p ${BACKUP_PATH}

# backup the database
/usr/bin/nice mongodump -u $MONGO_USERNAME -p $MONGO_PASSWORD -d openmrsid -out ${BACKUP_PATH}

chmod 640 -R ${BACKUP_PATH}
