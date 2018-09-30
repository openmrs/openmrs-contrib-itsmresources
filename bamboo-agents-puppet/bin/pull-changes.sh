#!/bin/bash

set -e
set -u
set -x

rm -rf /tmp/puppet
GIT_SSH_COMMAND='ssh -i /root/.ssh/github_id_rsa' git clone --depth 1 git@github.com:openmrs/openmrs-contrib-itsmresources.git /tmp/puppet
cd /tmp/puppet
GNUPGHOME="/root/ansible-gnupg" git-crypt unlock
rm -rf /etc/openmrs-puppet
mv /tmp/puppet/bamboo-agents-puppet /etc/openmrs-puppet
