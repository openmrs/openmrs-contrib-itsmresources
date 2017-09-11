OpenMRS Infrastructure Ansible Playbooks
======================
This repository contain all the ansible required to fully install OpenMRS community machines.

Ansible is a tool to run `playbooks` for machines of a certain `inventory`. Each machine
in an inventory can belong to several different groups. You can configure global variables
(an special group called `all`), per group or per host. Some of these configuration files
are encrypted using `ansible-vault`, and the shared key for vault is encrypted using `git-crypt`
and can be opened using private GPG keys previously added to the key ring.

Ansible will run over SSH, you your SSH needs to be working to the target machines.
You can also use vagrant to create test VMs for your ansible code.


## Requirements
* ansible 2.1+ installed on the same machine the repo is cloned to (do _NOT_ use version 2.3.0).
* Install [git-crypt](https://www.agwa.name/projects/git-crypt/) and run `git-crypt unlock`.
* If you are not part of git-crypt by any reason, you'll need to retrieve the vault password file from LP or ask to be added in git-crypt.
* Vagrant and virtualbox (if you want to run tests locally)


## Running ansible
The following assumes you are in the `ansible` directory:

```
# Download all roles/modules
$ ansible-galaxy install -p roles -r requirements.yml --force

# Run ansible in all staging machines
$ ansible-playbook -i inventories/staging site.yml --vault-password-file ./.vault_pass

# if you do not have your PGP key in our repo to unlock the .vault_pass file, you can get it from the LastPass folder and interactively enter it.
$ ansible-playbook -i inventories/staging site.yml --ask-vault-pass

This will unlock any ansible-vault files necessary for the playbook run.

# Run ansible in a single staging machines
$ ansible-playbook -i inventories/staging --limit djoum.openmrs.org site.yml --vault-password-file ./.vault_pass


# if you do not have your PGP key in our repo to unlock the .vault_pass file, you can get it from the LastPass folder and interactively enter it.
$ ansible-playbook -i inventories/staging --limit djoum.openmrs.org site.yml --ask-vault-pass

It might not be necessary to use vault for the single machine.

# Run arbitrary code
$ ansible -i inventories/production -m "whoami"
```

Instead of deploying ansible to another machine, it's possible to use vagrant VM instead:
```
# starting web VM (check Vagrantfile for more)
$ vagrant up web
$ vagrant ssh web
```


## Definitions

Ansible is a tool to run `playbooks` for machines of a certain `inventory`. Each machine
in an inventory can belong to several different groups. You can configure global variables
(an special group called `all`), per group or per host. Some of these configuration files
are encrypted using `ansible-vault`, and the shared key for vault is encrypted using `git-crypt`
and can be opened using private GPG keys previously added to the key ring.

Ansible will run over SSH, you your SSH needs to be working to the target machines.

## Repository
  - _site.yml_: default playbook, used to install everything
  - _delete-certs.yml_: playbook used to clean letsencrypt certificate and regenerate it
  - _update.yml_: playbook used to apply OS patches
  - _group_vars_ : variables and configuration per group
  - _host_vars_: variables and configuration per host
  - _inventories_ : machine definitions (groups per machine)
  - _tasks_: tasks used in playbooks
  - _roles_: external roles/modules downloaded by `galaxy`
  - _requirements.txt_: roles to be downloaded by `galaxy` into _roles_ folder
  - _ansible.cfg_: ansible configuration file
  - _Vagrantfile_: VM definition to test VMs locally
  - _spec_: test files called from vagrant VM
