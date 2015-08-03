#!/bin/bash
# Copyright 2013 Percona LLC and/or its affiliates
# http://www.mysqlperformanceblog.com/2013/12/24/renaming-database-schema-mysql/
#
# Changes
# - Uses --defaults-extra-file for credentials, host, and port settings
set -e
DEFAULTS=.my.cnf
if [ -z "$2" ]; then
    echo "rename_db <database> <new_database>"
    echo "(assumes $DEFAULTS defines user, password, host, and port under [client] section)"
    exit 1
fi
db_exists=`mysql --defaults-extra-file=$DEFAULTS -e "show databases like '$2'" -sss`
if [ -n "$db_exists" ]; then
    echo "ERROR: New database already exists $2"
    exit 1
fi
TIMESTAMP=`date +%s`
character_set=`mysql --defaults-extra-file=$DEFAULTS -e "show create database $1\G" -sss | grep ^Create | awk -F'CHARACTER SET ' '{print $2}' | awk '{print $1}'`
TABLES=`mysql --defaults-extra-file=$DEFAULTS -e "select TABLE_NAME from information_schema.tables where table_schema='$1' and TABLE_TYPE='BASE TABLE'" -sss`
STATUS=$?
if [ "$STATUS" != 0 ] || [ -z "$TABLES" ]; then
    echo "Error retrieving tables from $1"
    exit 1
fi
echo "create database $2 DEFAULT CHARACTER SET $character_set"
mysql --defaults-extra-file=$DEFAULTS -e "create database $2 DEFAULT CHARACTER SET $character_set"
TRIGGERS=`mysql --defaults-extra-file=$DEFAULTS $1 -e "show triggers\G" | grep Trigger: | awk '{print $2}'`
VIEWS=`mysql --defaults-extra-file=$DEFAULTS -e "select TABLE_NAME from information_schema.tables where table_schema='$1' and TABLE_TYPE='VIEW'" -sss`
if [ -n "$VIEWS" ]; then
    mysqldump --defaults-extra-file=$DEFAULTS $1 $VIEWS > /tmp/${1}_views${TIMESTAMP}.dump
fi
mysqldump --defaults-extra-file=$DEFAULTS $1 -d -t -R -E > /tmp/${1}_triggers${TIMESTAMP}.dump
for TRIGGER in $TRIGGERS; do
    echo "drop trigger $TRIGGER"
    mysql --defaults-extra-file=$DEFAULTS $1 -e "drop trigger $TRIGGER"
done
for TABLE in $TABLES; do
    echo "rename table $1.$TABLE to $2.$TABLE"
    mysql --defaults-extra-file=$DEFAULTS $1 -e "SET FOREIGN_KEY_CHECKS=0; rename table $1.$TABLE to $2.$TABLE"
done
if [ -n "$VIEWS" ]; then
    echo "loading views"
    mysql --defaults-extra-file=$DEFAULTS $2 < /tmp/${1}_views${TIMESTAMP}.dump
fi
echo "loading triggers, routines and events"
mysql --defaults-extra-file=$DEFAULTS $2 < /tmp/${1}_triggers${TIMESTAMP}.dump
TABLES=`mysql --defaults-extra-file=$DEFAULTS -e "select TABLE_NAME from information_schema.tables where table_schema='$1' and TABLE_TYPE='BASE TABLE'" -sss`
if [ -z "$TABLES" ]; then
    echo "Dropping database $1"
    mysql --defaults-extra-file=$DEFAULTS $1 -e "drop database $1"
fi
if [ `mysql --defaults-extra-file=$DEFAULTS -e "select count(*) from mysql.columns_priv where db='$1'" -sss` -gt 0 ]; then
    COLUMNS_PRIV="    UPDATE mysql.columns_priv set db='$2' WHERE db='$1';"
fi
if [ `mysql --defaults-extra-file=$DEFAULTS -e "select count(*) from mysql.procs_priv where db='$1'" -sss` -gt 0 ]; then
    PROCS_PRIV="    UPDATE mysql.procs_priv set db='$2' WHERE db='$1';"
fi
if [ `mysql --defaults-extra-file=$DEFAULTS -e "select count(*) from mysql.tables_priv where db='$1'" -sss` -gt 0 ]; then
    TABLES_PRIV="    UPDATE mysql.tables_priv set db='$2' WHERE db='$1';"
fi
if [ `mysql --defaults-extra-file=$DEFAULTS -e "select count(*) from mysql.db where db='$1'" -sss` -gt 0 ]; then
    DB_PRIV="    UPDATE mysql.db set db='$2' WHERE db='$1';"
fi
if [ -n "$COLUMNS_PRIV" ] || [ -n "$PROCS_PRIV" ] || [ -n "$TABLES_PRIV" ] || [ -n "$DB_PRIV" ]; then
    echo "IF YOU WANT TO RENAME the GRANTS YOU NEED TO RUN ALL OUTPUT BELOW:"
    if [ -n "$COLUMNS_PRIV" ]; then echo "$COLUMNS_PRIV"; fi
    if [ -n "$PROCS_PRIV" ]; then echo "$PROCS_PRIV"; fi
    if [ -n "$TABLES_PRIV" ]; then echo "$TABLES_PRIV"; fi
    if [ -n "$DB_PRIV" ]; then echo "$DB_PRIV"; fi
    echo "    flush privileges;"
fi
