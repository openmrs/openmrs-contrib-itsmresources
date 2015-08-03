mysql --defaults-extra-file=.my.cnf -e "create database openmrs1 DEFAULT CHARACTER SET utf8"
mysql --defaults-extra-file=.my.cnf openmrs1 < openmrs.sql
