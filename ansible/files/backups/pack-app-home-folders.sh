#!/bin/bash

set -eux

VM=${1}
echo "Packing application home folders $(date)"

for file in $(find /data/ -maxdepth 1 -name "*_home"); do
  echo "Folder $file"
  (cd $file
  tar --exclude="./artifacts" -zcvf /opt/backups/$(basename $file)-$(date +\%Y-\%m-\%d_\%H-\%M-\%S).tar.gz .)
done
