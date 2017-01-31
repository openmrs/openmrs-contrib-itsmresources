#!/bin/bash

# Simple script to backup the LDAP database -- ultimately we will want to back
# these up to Amazon Glacier or S3.

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_PATH="/var/backups/ldap/${TIMESTAMP}"
mkdir -p "${BACKUP_PATH}"

# backup the database
/usr/bin/nice /usr/sbin/slapcat -n 1 > "${BACKUP_PATH}/openmrs_ldap_backup.ldif"

tar cpjf "${BACKUP_PATH}/etc_ldap.tbz2" /etc/ldap >/dev/null 2>&1
tar cpjf "${BACKUP_PATH}/var_lib_ldap.tbz2" /var/lib/ldap >/dev/null 2>&1

chmod 640 -R "${BACKUP_PATH}"
