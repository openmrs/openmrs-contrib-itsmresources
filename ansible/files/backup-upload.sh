#!/bin/bash

set -e
set -u
set -x

VM=${1}
for file in $(find /opt/backups -type f); do
  echo "Uploading Nightly backups for $(date)"
  /usr/local/bin/aws s3 cp --sse "aws:kms" $file s3://openmrs-backups/${VM}/
  rm -f $file
done
