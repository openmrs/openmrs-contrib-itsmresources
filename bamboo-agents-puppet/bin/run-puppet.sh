#!/bin/bash

cd /etc/puppet/
git pull --rebase
librarian-puppet install
puppet apply /etc/puppet/manifests/site.pp
