#!/bin/bash

set -e
set -u
set -x

cd /etc/puppet/
librarian-puppet install
puppet apply /etc/puppet/manifests/site.pp
