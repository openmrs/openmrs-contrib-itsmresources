#!/bin/sh
# This script checkpoints the ldab db and then archives the log files.
# Use && to ensure checkpoint is successful before archiving.
# Runs this nightly from crontab.
db5.1_checkpoint -1 -v -h /var/lib/ldap && db5.1_archive -d -v -h /var/lib/ldap
