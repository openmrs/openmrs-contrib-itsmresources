#!/bin/sh
# This script checkpoints the ldab db and then archives the log files.
# Use && to ensure checkpoint is successful before archiving.
# Runs this nightly from crontab.
db5.3_checkpoint -1 -v -h /opt/id/data/ldap/database && db5.3_archive -d -v -h /opt/id/data/ldap/database
