#!/bin/bash
# change to current directory((remote workaround)
cd ${0%/*}
echo "Restoring openmrs1 db"
./restore-openmrs1.sh
echo "Replacing openmrs with openmrs1"
./replace-openmrs.sh
echo "locking admin pwd"
mysql --defaults-extra-file=.my.cnf openmrs < lock-admin.sql
