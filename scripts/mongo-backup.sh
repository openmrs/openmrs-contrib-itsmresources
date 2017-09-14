#!/bin/bash
# Simple script to backup mongodb nightly
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_PATH="/tmp/mongodb/${TIMESTAMP}"
TARBALL="/opt/backups/${TIMESTAMP}_openmrsid_mongodb.tbz2"

. $HOME/.cronfile

mkdir -p "$BACKUP_PATH"
# backup the database
/usr/bin/nice mongodump -u "$MONGO_USERNAME" -p "$MONGO_PASSWORD"  --db openmrsid -o "$BACKUP_PATH"
cd "${BACKUP_PATH}" ; tar cpjf "${TARBALL}" .
chmod 0600 "${TARBALL}"
rm -fr ${BACKUP_PATH}
chown -R backup-s3:backup-s3 "${TARBALL}"
