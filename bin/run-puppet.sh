#!/bin/bash

cd /etc/puppet/
git pull
librarian-puppet install
puppet apply /etc/puppet/manifests/site.pp