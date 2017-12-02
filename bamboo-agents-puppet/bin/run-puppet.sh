#!/bin/bash

cd /etc/puppet/
librarian-puppet install
puppet apply /etc/puppet/manifests/site.pp
