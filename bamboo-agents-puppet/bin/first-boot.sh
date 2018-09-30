#!/bin/bash

set -e
set -u
set -x

HIERA_ENVIRONMENT="${1:-production}"
GUARD_FILE="/etc/first_boot_puppet.lock"

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
apt-get -y update
apt-get -o Dpkg::Options::="--force-confold" install -y puppet-agent

ln -sf /etc/openmrs-puppet/hiera.yaml /etc/puppetlabs/puppet/hiera.yaml
echo "hiera_environment=${HIERA_ENVIRONMENT}" > /opt/puppetlabs/facter/facts.d/hiera_environment.txt

gem install librarian-puppet
/opt/puppetlabs/puppet/bin/gem install hiera-eyaml

touch $GUARD_FILE
