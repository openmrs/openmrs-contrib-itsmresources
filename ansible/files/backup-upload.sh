#!/bin/bash

set -e
set -u
set -x

VM=${1}

cd /opt/backups/
echo "Uploading Nightly backups for $(date)" >> /tmp/backups.log
for file in $(find . -type f); do
  aws s3 cp --sse "aws:kms" $file s3://openmrs-backups/${VM}/ >> /tmp/backups.log
  rm -f $file
done
