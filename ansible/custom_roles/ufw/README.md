Role Name
========

ufw

Role Variables
--------------
```

# Enables managing ufw rules
manage_ufw: true

# Hash of ufw rules to manage
ufw_rules:
  rule_name:

# Hash of ufw config
ufw_config:
  configname:

```

Example Playbook
-------------------------
### playbook.yml

```

---
- hosts: all
  roles:
  - ufw

  vars:
    ufw_rules:
      http:
        port: 80
        proto: tcp
        rule: allow
      https:
        port: 443
        proto: tcp
        rule: allow 

    ufw_config:
      globalconfig:
        direction: incoming
        logging: "off"
        policy: reject
        state: enabled

```

License
-------

Apache 2.0

Author Information
------------------

Ryan Yates
