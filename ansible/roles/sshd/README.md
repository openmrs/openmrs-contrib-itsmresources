Role Name
========

sshd

Role Variables
--------------
```

# Enables managing sshd config, defaults to on.
manage_sshd: true

# Default service name for ssh if it doesn't match anything in vars/.  Shouldn't need to set this if you have a Debian or RedHat based distro.
ssh_service_name: sshd

```

Example Playbook
-------------------------
### playbook.yml

```

---
- hosts: all
  roles:
  - sshd

```

License
-------

Apache 2.0

Author Information
------------------

Ryan Yates
