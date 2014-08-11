Role Name
========

server-common

Role Variables
--------------

Variables below are used to control what the role does during a run.  By default these are on.  You can adjust these either in group_vars or host_vars.
- add_users
- manage_ssh
- manage_sudoers

If the add_users variable is true then it will add users and groups that are defined in the way below.
```
othergroups:
 newgroup:
   gid: 1001

users:
 user:
   comment: Me
   groups: ['newgroup']
   uid: 1001
   ssh_key: "ssh-rsa "AAAA.....ZZZZ me@example.com"
```

Example Playbook
-------------------------
### playbook.yml
```
---
- hosts: all
  roles:
  - server-common

```

### group_vars/all
```
# Users and group we want to add to all hosts (sysadmins)
othergroups:
 testadmin:
   gid: 2001
# The first users is the minimum required. The second user is using all options.
users:
 test1:
   groups: ['testadmin']
 test2:
    groups: ['testadmin']
    comment: Test User 2
    shell: "/bin/zsh"
    uid: 3000
    createhome: no
    generate_ssh_key: yes
    home: /opt/test2
    password: "$6...A."
    ssh_key_bits: 4096



# Uncomment variables below to disable functions of server-common
# Add users/groups/ssh keys
#add_users: false
#
# Manage ssh
#manage_ssh: false
#
# Manage sudoers
#manage_sudoers: false
```

License
-------

Apache

Author Information
------------------

Ryan Yates, ryan@openmrs.org
