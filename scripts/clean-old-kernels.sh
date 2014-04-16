#/bin/sh
# clean-old-kernels.sh - Cleans old kernel images and headers.
# Use this after installing a new kernel and rebooting, so you are on the latest kernel.
dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
