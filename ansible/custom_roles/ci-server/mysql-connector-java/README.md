Ansible Role for MySQL Connector/J
==================================

[![Build Status](https://travis-ci.org/pantarei/ansible-role-mysql-connector-java.svg?branch=master)](https://travis-ci.org/pantarei/ansible-role-mysql-connector-java)
[![GitHub tag](https://img.shields.io/github/tag/pantarei/ansible-role-mysql-connector-java.svg)](https://github.com/pantarei/ansible-role-mysql-connector-java)
[![GitHub license](https://img.shields.io/github/license/pantarei/ansible-role-mysql-connector-java.svg)](https://github.com/pantarei/ansible-role-mysql-connector-java/blob/master/LICENSE)

Ansible Role for Ubuntu MySQL Connector/J Installation.

Requirements
------------

This role require Ansible 2.0 or higher.

This role was designed for Ubuntu Server 14.04 LTS and Ubuntu Server 16.04 LTS.

Role Variables
--------------

<table>
<colgroup>
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
</colgroup>
<thead>
<tr class="header">
<th>parameter</th>
<th>required</th>
<th>default</th>
<th>choices</th>
<th>comments</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>mysql_connector_java_archive</td>
<td>yes</td>
<td><a href="https://github.com/pantarei/ansible-role-mysql-connector-java/blob/master/defaults/main.yml">defaults/main.yml</a></td>
<td></td>
<td>Download archive filename for cache during (re)install.</td>
</tr>
<tr class="even">
<td>mysql_connector_java_dest</td>
<td>yes</td>
<td>/tmp</td>
<td></td>
<td>Destination directory where MySQL Connector/J .jar should install to.</td>
</tr>
<tr class="odd">
<td>mysql_connector_java_jar</td>
<td>yes</td>
<td><a href="https://github.com/pantarei/ansible-role-mysql-connector-java/blob/master/defaults/main.yml">defaults/main.yml</a></td>
<td></td>
<td>MySQL Connector/J .jar filename for double check if installed to target directory correctly.</td>
</tr>
<tr class="even">
<td>mysql_connector_java_sha256</td>
<td>yes</td>
<td><a href="https://github.com/pantarei/ansible-role-mysql-connector-java/blob/master/defaults/main.yml">defaults/main.yml</a></td>
<td></td>
<td>Download archive sha256 checksum for cache during (re)install.</td>
</tr>
<tr class="odd">
<td>mysql_connector_java_url</td>
<td>yes</td>
<td><a href="https://github.com/pantarei/ansible-role-mysql-connector-java/blob/master/defaults/main.yml">defaults/main.yml</a></td>
<td></td>
<td>URL for download archive.</td>
</tr>
<tr class="even">
<td>mysql_connector_java_user</td>
<td>yes</td>
<td>jira</td>
<td></td>
<td>Username for destination directory and extracted .jar.</td>
</tr>
</tbody>
</table>

Dependencies
------------

No additional role dependencies.

Example Playbook
----------------

    - hosts: all
      roles:
        - role: hswong3i.mysq_connector_java
          mysql_connector_java_dest: "/tmp/ansible-role-mysql-connector-java"
          mysql_connector_java_user: "root"

License
-------

-   Code released under [MIT](https://github.com/pantarei/ansible-role-mysql-connector-java/blob/master/LICENSE)
-   Docs released under [CC BY 4.0](http://creativecommons.org/licenses/by/4.0/)

Author Information
------------------

-   Wong Hoi Sing Edison
    -   <a href="https://twitter.com/hswong3i" class="uri" class="uri">https://twitter.com/hswong3i</a>
    -   <a href="https://github.com/hswong3i" class="uri" class="uri">https://github.com/hswong3i</a>

