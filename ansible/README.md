OpenMRS Infrastructure Ansible Playbooks
======================
Ansible playbooks that should be run on all servers.


## Roles currently configured
* users
* sshd
* sudo
* ufw
* ssl-keys

## Requirements
* This repo.
* ansible  2.1+ installed on the same machine the repo is cloned to.
* Run `cd ansible && ansible-galaxy install --roles-path=roles --role-file=roles/roles-requirements.yml --force` to retrieve all roles

## How to use this
To run this on a set of machines ('inventory'), currently (production, staging, testing).

`ansible-playbook -i inventories/testing site.yml`

This will run all roles against the inventory you specified. This will also assume you want to log into the server using your current user. use the `-u` switch to specify another user. The use of `--sudo` will use sudo when needed as well.

Look into each role in the roles directory to find out what each role does.

## Example tasks
### Adding a user to a specific host
If we want to add the user `john` to only the host `dschang.openmrs.org`, with sudo privileges via the `admin` group, you would do the following.

edit `host_vars/dschang.openmrs.org` and add this hash under `users:` if it doesn't already exist.  **Remember: white space is important**

    ---
    users:
      john:
        comment: John Johnson
        groups: 'admin'
        ssh_key: "ssh-rsa AAAA...Uvbf john@john.net"

Then run the playbook

`ansible-playbook -i inventories/staging site.yml --sudo`

## Running example ad-hoc commands
#### Updating all packages on staging servers
#### New Update play book
This will do a dry run of updating all packages on the staging boxes.

`ansible-playbook -i inventories/staging update.yml --check -v`

When satisfied this will not breaking anything drop the `--check` and it will update all servers int the inventory.

#### Update a certain package to latest version on production

`ansible -i inventories/production all -m apt -a "update_cache=yes name=openssl state=latest" --become`

This will only update the package to the latest version if it is already installed.  It will not install the openssl package on hosts that do not have it installed.
