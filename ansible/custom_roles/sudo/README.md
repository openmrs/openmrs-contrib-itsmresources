Role Name
========

sudo

Role Variables
--------------
```
# Users with access to sudo
sudo_users:
  - root
  - "%wheel"
  - "%sudo"

# Password required for sudo use.
sudo_nopasswd: true

```

Example Playbook
-------------------------
### playbook.yml

```

---
- hosts: all
  roles:
  - sudo

  vars:
   sudo_users:
     - root
     - admin

```

License
-------

Apache 2.0

Author Information
------------------

Ryan Yates
