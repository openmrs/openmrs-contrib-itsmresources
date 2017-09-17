#!/bin/bash

set -eux

VM=${1}
echo "Uploading Nightly backups for $(date)"

for file in $(find /opt/backups -type f); do
  echo "File $file"
  /usr/local/bin/aws s3 cp --sse "aws:kms" $file s3://openmrs-backups/${VM}/
  rm -f $file
done
