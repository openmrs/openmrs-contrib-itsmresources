#!/bin/bash

set -e
set -u
set -x

rm -rf /tmp/puppet
GIT_SSH_COMMAND='ssh -i /root/.ssh/github_id_rsa' git clone --depth 1 git@github.com:openmrs/openmrs-contrib-itsmresources.git /tmp/puppet
rm -rf /etc/puppet
mv /tmp/puppet/bamboo-agents-puppet /etc/puppet
