#!/bin/bash

set -e
set -u
set -x

VM=${1}

cd /opt/backups/
for file in $(find . -type f); do
  aws s3 cp --sse "aws:kms" $file s3://openmrs-backups/${VM}/
  rm -f $file
done
