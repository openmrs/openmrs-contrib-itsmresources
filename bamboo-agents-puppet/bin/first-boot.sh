#!/bin/bash -eu

GUARD_FILE="/tmp/first_boot.log"

if [ -f "$GUARD_FILE" ]; then
	echo "Not first boot; skipping basic installation.... "
	exit 0
fi

echo "Installing basic dependencies...."
echo 'Installing git, ruby-dev and puppet'
apt-get update
apt-get -q -y install git
apt-get install -y ruby-dev make
apt-get install -y -o Dpkg::Options::="--force-confold" puppet
apt-get -y autoremove

touch $GUARD_FILE
