#!/bin/bash
# Simple script to backup mongodb nightly
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_PATH="/opt/backups/mongodb/${TIMESTAMP}"
. $HOME/.cronfile

mkdir -p "$BACKUP_PATH"
# backup the database
/usr/bin/nice mongodump -u "$MONGO_USERNAME" -p "$MONGO_PASSWORD"  --db openmrsid -o "$BACKUP_PATH"
chmod 640 -R "$BACKUP_PATH"
chown -R backup-s3:backup-s3 "$BACKUP_PATH"
