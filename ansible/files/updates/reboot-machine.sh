#!/bin/bash

set -eux

/bin/date

if [ -f /var/run/reboot-required ]; then
  /bin/echo "Rebooting machine due to patches applied."
  /sbin/reboot -h
else
  /bin/echo "Nothing to do."
fi
