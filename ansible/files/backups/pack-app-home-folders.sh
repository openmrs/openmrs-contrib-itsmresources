#!/bin/bash

set -eux

VM=${1}
echo "Packing application home folders $(date)"

for file in $(find /data/ -maxdepth 1 -name "*_home"); do
  echo "Folder $file"
  if [ $file = "/data/bamboo_home" ]
  then
    (cd $file
     tar --exclude="./shared/builds" --exclude="./local-working-dir" -zcvf /opt/backups/$(basename $file)-$(date +\%Y-\%m-\%d_\%H-\%M-\%S).tar.gz .)
  else
    (cd $file
    tar -czvf /opt/backups/$(basename $file)-$(date +\%Y-\%m-\%d_\%H-\%M-\%S).tar.gz .)
  fi
done
