Role Name
========

server-common

Role Variables
--------------

Variables below are used to control what the role does during a run.  By default these are on.  You can adjust these either in group_vars or host_vars.
- add_users
- manage_ssh
- manage_sudoers

If the add_users variable is true then it will add users that are defined in the way below.
othergroups:
 - groupname: newgroup
   gid: 1001

users:
 - username: user
   name: Me
   groups: ['newgroup']
   uid: 1001
   ssh_key:
     - "ssh-rsa "AAAA.....ZZZZ"

Example Playbook
-------------------------



# Group vars example
# Users and group we want to add to all hosts (sysadmins)
othergroups:
 - groupname: testadmin
   gid: 2001

users:
 - username: test1
   name: Test 1
   groups: ['testadmin']
   uid: 1001
   ssh_key:
     - "ssh-rsa AAAA...ZZZZ test1@example.com"
 - username: test2
   name: Test 2
   groups: ['testadmin']
   uid: 1002
   ssh_key:
    - "ssh-rsa AAAA...ZZZZ test2@example.com

# Uncomment variables below to disable functions of server-common
# Add users/groups/ssh keys
#add_users: false
#
# Manage ssh
#manage_ssh: false
#
# Manage sudoers
#manage_sudoers: false

License
-------

Apache

Author Information
------------------

Ryan Yates, ryan@openmrs.org
