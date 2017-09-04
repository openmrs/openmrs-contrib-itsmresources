#!/bin/bash

set -e
set -u
set -x


cd /opt/backups/
for file in $(ls); do
  aws s3 cp --sse "aws:kms" $file s3://openmrs-backups/$(hostname)/
  rm -f $file
done
