OpenMRS Infrastructure Ansible Master Playbook
======================
Master playbook that should be run on all servers.

## Roles currently configured
* server-common

## Requirements
* This repo.
* ansible installed on the same machine the repo is cloned to.

## How to use this
To run this on a set of machines , currently (production, staging, testing).

`ansible-playbook -i testing site.yml`

This will run all roles against the inventory you specified. This will also assume you want to log into the server using your current user. use the `-u` switch to specify another user.

If you want to run a specific task/role on a set of machines.

`ansible-playbook -i testing server-common.yml`

Look into each role in the roles directroy to find out what each role does.


