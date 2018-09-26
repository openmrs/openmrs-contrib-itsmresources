#!/bin/bash

set -e
set -u
set -x

cd /etc/openmrs-puppet/
librarian-puppet install
puppet apply --module-path="/etc/openmrs-puppet/modules:/etc/openmrs-puppet/openmrs-modules" /etc/openmrs-puppet/manifests/site.pp
