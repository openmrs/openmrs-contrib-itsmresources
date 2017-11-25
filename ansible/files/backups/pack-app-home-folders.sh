#!/bin/bash

set -eux

VM=${1}
echo "Packing application home folders $(date)"

for file in $(find /data/ -maxdepth 1 -name "*_home" | fgrep -r bamboo); do
  echo "File $file"
  tar -czvf /opt/backups/$(basename $file)-$(date +\%Y-\%m-\%d_\%H-\%M-\%S).tar.gz
done
