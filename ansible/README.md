OpenMRS Infrastructure Ansible Playbooks
======================
Ansible playbooks that should be run on all servers.
This repository has vagrant configured.


## Roles currently configured
* users
* sshd
* sudo
* ufw

### Roles only configured on select hosts

* docker
* docker-compose
* ssl-keys
* nginx

## Requirements
* This repo.
* ansible  2.1+ installed on the same machine the repo is cloned to.
* Create a `~/.vault` file with the vault password defined in LP.

The following assumes you are in the `ansible` directory:

* Run `ansible-galaxy install -p roles -r requirements.yml --force` to retrieve all roles

## How to use this
To run this on a set of machines ('inventory'), currently (production, staging, testing).

`ansible-playbook -i inventories/testing --vault-password-file ~/.vault site.yml`

This will run all roles against the inventory you specified. This will also assume you want to log into the server using your current user. use the `-u` switch to specify another user. The use of `-b` will use sudo when needed as well.

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

Then run the playbook to all machines in staging:
`ansible-playbook -i inventories/staging site.yml -b`

To run against a single server:
`ansible-playbook -i inventories/staging --limit djoum.openmrs.org site.yml `

## Running example ad-hoc commands
#### Updating all packages on staging servers
#### New Update play book
This will do a dry run of updating all packages on the staging boxes.

`ansible-playbook -i inventories/staging update.yml --check -v`

When satisfied this will not breaking anything drop the `--check` and it will update all servers int the inventory.

#### Update a certain package to latest version on production

`ansible -i inventories/production all -m apt -a "update_cache=yes name=openssl state=latest" -b`

This will only update the package to the latest version if it is already installed.  It will not install the openssl package on hosts that do not have it installed.
