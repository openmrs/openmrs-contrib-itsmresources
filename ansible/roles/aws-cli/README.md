Ansible role: aws_cli
=====================

[![Build status](https://img.shields.io/travis/com/badpacketsllc/ansible-aws_cli.svg?style=flat)](https://travis-ci.com/badpacketsllc/ansible-aws_cli)
[![Ansible role](https://img.shields.io/ansible/role/37536.svg?style=flat)](https://galaxy.ansible.com/badpacketsllc/aws_cli)
[![Ansible role quality](https://img.shields.io/ansible/quality/37536.svg?style=flat)](https://galaxy.ansible.com/badpacketsllc/aws_cli)
[![Ansible role downloads](https://img.shields.io/ansible/role/d/37536.svg?style=flat)](https://galaxy.ansible.com/badpacketsllc/aws_cli)
[![License](https://img.shields.io/github/license/badpacketsllc/ansible-aws_cli.svg?style=flat)](https://github.com/badpacketsllc/ansible-aws_cli/blob/master/LICENSE)
[![Follow us on twitter](https://img.shields.io/twitter/follow/bad_packets.svg?style=social)](https://twitter.com/bad_packets/)

Description
-----------

A role to install and configure the
[AWS Command Line Interface (CLI)](https://aws.amazon.com/cli/).

This role features:
- Full test coverage.
- Support for configuring as many roles are you like.
- Configuration of variables on both the role- or profile-level. Profile-level
  variables take precedence over role-level variables. 
- No default profile-level configuration variables.
- Writing nothing to config files when nothing is provided. If you want the
  role to only install the AWS CLI and prefer to configure things
  using environment variables.
- Global definition of AWS CLI variables. For example, if you want to use the
  `us-east-2` region throughout every profile, just use `region: us-east-2`
  in your playbook.
- Support for most major platforms.

Installation
------------

Using `ansible-galaxy`:

```shell
$ ansible-galaxy install badpacketsllc.aws_cli
```

Using `requirements.yml`:

```yaml
---
- src: badpacketsllc.aws_cli
```

Using `git`:

```shell
$ git clone https://github.com/badpacketsllc/ansible-aws_cli.git
```


Role Variables
--------------

| variable name         | default value                                                                                                                                                    | description                                                                                                   | required |
|-----------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------|----------|
| aws_cli_user          | [{{ ansible_user }}](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html?highlight=ansible_user#variables-discovered-from-systems-facts) | name of the user who will run the `aws` command                                                               | no       |
| aws_cli_user_group    | `{{ aws_cli_user }}`                                                                                                                                             |                                                                                                               | no       |
| aws_user_dir          | `"/home/{{ aws_cli_user }}/.aws"`                                                                                                                                | home directory of the user who will run the `aws` command                                                     | no       |                                                         | no       |
| profiles              | none                                                                                                                                                             | `aws` [profile names](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)           | no       |
| region                | none                                                                                                                                                             | aws region where your resources life                                                                          | no       |
| output                | none                                                                                                                                                             | cli output format                                                                                             | no       |
| aws_access_key_id     | none                                                                                                                                                             | aws iam [access key](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html)        | no       |
| aws_secret_access_key | none                                                                                                                                                             | aws iam [secret access key](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html) | no       |

Example Playbook
----------------

```yaml
---
- hosts: all

  tasks:
    - name: Set up aws-cli
      import_role:
        name: badpacketsllc.aws_cli
      vars:
        profiles:
          - name: default
            region: us-east-1
            output: text
            aws_access_key_id: AKIAIOSDNKOW7EXAMPLE
            aws_secret_access_key: wJalrXUtnFEMI/F3GXCLG/bPxRfiCYEXAMPLEKEY
```

#### Results:

```shell
$ cat ~/.aws/config
# Ansible managed

[default]
region = us-east-1
output = text

```

```shell
$ cat ~/.aws/credentials
# Ansible managed

[default]
aws_access_key_id = AKIAIOSDNKOW7EXAMPLE
aws_secret_access_key = wJalrXUtnFEMI/F3GXCLG/bPxRfiCYEXAMPLEKEY

```

You can find more examples, including the use of multiple profiles, in the
[test suite](https://github.com/badpacketsllc/ansible-aws_cli/blob/master/molecule/default/playbook.yml).

Note: do not put cleartext secrets under version control. Consider using an
[encrypted file](https://docs.ansible.com/ansible/latest/user_guide/vault.html)
or an environment variable.

Contributing
------------

Contributions are encouraged! Learn how to contribute by reading
[CONTRIBUTING.md](https://github.com/badpacketsllc/ansible-aws_cli/blob/master/CONTRIBUTING.md).
Please be nice and follow our
[Code of Conduct](https://www.contributor-covenant.org/version/1/4/code-of-conduct).

License
-------

GPLv3

Author Information
------------------

[Mathew Woodyard](https://www.woodrad.com)

[@mat_packets](https://twitter.com/mat_packets)

[Bad Packets LLC](https://badpackets.net)

Contributors
------------

Special thanks to:
- [crashsystems](http://crashsystems.net/) for his code review.
