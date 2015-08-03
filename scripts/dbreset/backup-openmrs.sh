mysqldump --defaults-extra-file=.my.cnf --add-drop-database --extended-insert \
    --single-transaction openmrs > openmrs.sql
