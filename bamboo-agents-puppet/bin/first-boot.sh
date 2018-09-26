#!/bin/bash

set -e
set -u
set -x

GUARD_FILE="/var/run/first_boot_puppet.lock"

if [ -f "$GUARD_FILE" ]; then
	echo "Not first boot; skipping basic installation.... "
	exit 0
fi

echo "Installing basic dependencies...."
echo 'Installing git, ruby-dev and puppet'
apt-get update
apt-get -q -y install git
apt-get install -y ruby-dev make

wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
dpkg -i puppetlabs-release-pc1-xenial.deb
apt-get update
apt-get install -y puppet-agent
apt-get -y autoremove

ln -sf /etc/puppet/hiera.yaml /etc/puppetlabs/puppet/hiera.yaml

gem install librarian-puppet

touch $GUARD_FILE
