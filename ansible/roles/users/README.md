Role Name
========

users

Role Variables
--------------

Variables below are used to control what the role does during a run.  You can find the defaults in `defaults/main.yml`.
- **manage_users**   *used to control whether this role is used or not.*
- **users_default_shell**    *default shell for users unless one is specified.*
- **users_default_createhome**    *creates a home directory for the user during creation.*
- **users_default_create_user_group**   *creates groups based on user name. **If you disable this you must set the `group` for each user and the group must exist or created in `othergroups`.***
- **users_default_removehome**   *When state is set to absent, also remove the users home directory.*

Users and groups you want to manage are all defined in the vars of the playbook.  This can be in group_vars, host_vars, or vars: in a play.  If you have the `users` hash defined in two places such as `group_vars/all` and `host_vars/foo` and want both sets of users on the foo host you will want to add `hash_behaviour = merge` to your anisble.cfg to enable this.

Example Playbook
-------------------------
### playbook.yml

```

---
- hosts: all
  roles:
  - users

  vars:
    othergroups:
      testadmin:
        gid: 2001
      somegroup:

    users:
      test1:
      test2:
        groups: 'testadmin,somegroup'
        comment: 'Test User 2'
        shell: '/bin/zsh'
        uid: 3000
        createhome: no
        generate_ssh_key: yes
        ssh_key: "ssh-rsa AAAAA....ZZZZ me@example.com"
      test3:
        state: absent
        removehome: yes

```

License
-------

Apache 2.0

Author Information
------------------

Ryan Yates
