#!/bin/bash

ci_server=ci.openmrs.org

## ssh into main bamboo server and run the backup_db script
ssh bamboo@$ci_server /opt/scripts/backup_db.sh
