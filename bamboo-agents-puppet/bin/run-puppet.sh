#!/bin/bash

set -e
set -u
set -x

cd /etc/openmrs-puppet/
r10k puppetfile install -v
/opt/puppetlabs/bin/puppet apply --modulepath "/etc/openmrs-puppet/modules:/etc/openmrs-puppet/openmrs-modules" /etc/openmrs-puppet/manifests/site.pp
