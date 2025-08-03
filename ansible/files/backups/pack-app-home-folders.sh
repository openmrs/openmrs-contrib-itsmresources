#!/bin/bash

set -eux

# https://confluence.atlassian.com/bamboo/locating-important-directories-and-files-289277247.html
# For bamboo:
#   - local-working-dir is a git cache, will be recreated
#   - shared/builds can be recreated (to be confirmed)
#   - shared/artifacts aren't being used since 2017 (it's now on S3)
#   - shared/exports contain any export we attempted from Bamboo data

VM=${1}
echo "Packing application home folders $(date)"

for file in $(find /data/ -maxdepth 1 -name "*_home"); do
  echo "Folder $file"
  if [ $file = "/data/bamboo_home" ]
  then
    (cd $file
     tar --exclude="./shared/exports" --exclude="./temp" --exclude="./logs" --exclude="./caches" --exclude="./shared/artifacts" --exclude="./shared/builds" --exclude="./local-working-dir" -zcvf /opt/backups/$(basename $file)-$(date +\%Y-\%m-\%d_\%H-\%M-\%S).tar.gz .)
  else
    (cd $file
    tar -czvf /opt/backups/$(basename $file)-$(date +\%Y-\%m-\%d_\%H-\%M-\%S).tar.gz .)
  fi
done
