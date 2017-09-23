#!/bin/bash
set -eux
# Simple script to backup the LDAP database

TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_PATH="/tmp/ldap/${TIMESTAMP}"
mkdir -p "${BACKUP_PATH}"
TARBALL="/opt/backups/${TIMESTAMP}_openmrsid_ldap.tbz2"

# backup the config
/usr/bin/nice docker-compose -f /opt/id/docker-compose-prod.yml exec openldap slapcat -n 0 > "${BACKUP_PATH}/config.ldif"

# backup the database (bring down slapd)
/usr/bin/nice docker-compose -f /opt/id/docker-compose-prod.yml exec openldap slapcat -n 1 > "${BACKUP_PATH}/openmrs_ldap_backup.ldif"

/usr/bin/nice docker-compose -f /opt/id/docker-compose-prod.yml stop openldap

/usr/bin/nice tar cpjf "${BACKUP_PATH}/ldap_database.tbz2" /opt/id/data/ldap/database >/dev/null 2>&1

# bring slapd back up now

/usr/bin/nice docker-compose -f /opt/id/docker-compose-prod.yml start openldap


/usr/bin/nice tar cpjf "${BACKUP_PATH}/ldap_config.tbz2" /opt/id/data/ldap/config >/dev/null 2>&1

cd "$BACKUP_PATH" ; tar cpjf "${TARBALL}" .

chmod 0600 "${TARBALL}"

rm -fr "${BACKUP_PATH}"

chown -R backup-s3:backup-s3 "${TARBALL}"
