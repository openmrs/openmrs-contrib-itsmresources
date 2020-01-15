OpenMRS Infrastructure Ansible Playbooks
======================
This repository contain all the ansible required to fully install OpenMRS community machines.


## Running ansible
All commands assume you are in the `ansible` directory.

### Requirements
* ansible 2.9.2 installed on the same machine the repo is cloned to.
* Install [git-crypt](https://www.agwa.name/projects/git-crypt/) and run `git-crypt unlock`.
  * If you are not part of git-crypt by any reason, you'll need to retrieve the vault password file from LP or ask to be added in git-crypt.
* Install `pip install passlib` (is it still needed???)
* Install latest Vagrant and virtualbox (if you want to run tests locally)

### Downloading all roles

```
# Download all roles/modules (needs to be done every time there's a commit to a role)
$ ansible-galaxy install -p roles -r requirements.yml --force
```


### Running ansible for remote machines

```
# Run main ansible playbook in a single testing machine (e.g. narok)
$ ansible-playbook -vv -i inventories/prod-tier4 --limit narok.openmrs.org site.yml


# Run ansible in all machines in tier 4
$ ansible-playbook -vv -i inventories/prod-tier4 site.yml


# if you do not have your PGP key in our repo to unlock the .vault_pass file, you can get it from the LastPass folder and interactively enter it.
$ ansible-playbook -vv -i inventories/prod-tier4 --limit narok.openmrs.org site.yml --ask-vault-pass


# Add new DNS entry to letsencrypt (example: narok)
# after changing the host_vars
$ ansible-playbook -vv -i inventories/prod-tier4 --limit narok.openmrs.org remove-certs.yml
$ ansible-playbook -vv -i inventories/prod-tier4 --limit narok.openmrs.org --tags tls,web,docker site.yml
```

### Editing ansible encrypted files

```
$ ansible-vault edit --vault-password-file .vault_pass /path/to/encrypted/file
```

### Running locally

Instead of deploying ansible to another machine, it's possible to use vagrant VM instead:


```
# see status of all VMs
$ vagrant status

# starting soe (base) VM
$ vagrant up soe

# rerunning ansible and serverspec tests
$ vagrant provision soe

# ssh into the VM
$ vagrant ssh soe

# stop the VM
$ vagrant halt soe

# destroy the VM
$ vagrant destroy soe
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
  - _remove-certs.yml_: playbook used to clean letsencrypt certificate and regenerate it (note: it stops nginx)
  - _remove-users.yml_: playbook used to delete old users and home folders


  - _group_vars_ : variables and configuration per group
  - _host_vars_: variables and configuration per host
  - _inventories_ : machine definitions (groups per machine)
  - _tasks_: tasks used in playbooks
  - _roles_: external roles/modules downloaded by `galaxy`
  - _requirements.txt_: roles to be downloaded by `galaxy` into _roles_ folder
  - _ansible.cfg_: ansible configuration file
  - _Vagrantfile_: VM definition to test VMs locally
  - _spec_: test files called from vagrant VM
