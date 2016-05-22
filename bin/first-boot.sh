#!/bin/bash -e

GUARD_FILE="/tmp/first_boot.log"

if [ -f "$GUARD_FILE" ]; then 
	echo "Not first boot; skipping basic installation.... "
	exit 0
fi

echo "Installing basic dependencies...."
echo 'Installing git and ruby-dev'
apt-get update
apt-get -q -y install git
apt-get install -y ruby-dev make
apt-get -y autoremove

touch $GUARD_FILE   
    