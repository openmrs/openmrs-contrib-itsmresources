Ansible Role for Confluence
===========================

[![Build Status](https://travis-ci.org/pantarei/ansible-role-confluence.svg?branch=master)](https://travis-ci.org/pantarei/ansible-role-confluence)
[![GitHub tag](https://img.shields.io/github/tag/pantarei/ansible-role-confluence.svg)](https://github.com/pantarei/ansible-role-confluence)
[![GitHub license](https://img.shields.io/github/license/pantarei/ansible-role-confluence.svg)](https://github.com/pantarei/ansible-role-confluence/blob/master/LICENSE)

Ansible Role for Atlassian Confluence Installation.

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
<td>confluence_archive</td>
<td>yes</td>
<td><a href="https://github.com/pantarei/ansible-role-confluence/blob/master/defaults/main.yml">defaults/main.yml</a></td>
<td></td>
<td>Download archive filename for cache during (re)install.</td>
</tr>
<tr class="even">
<td>confluence_catalina</td>
<td>yes</td>
<td>/usr/share/confluence</td>
<td></td>
<td>Location for the Confluence installation directory.</td>
</tr>
<tr class="odd">
<td>confluence_checksum</td>
<td>yes</td>
<td><a href="https://github.com/pantarei/ansible-role-confluence/blob/master/defaults/main.yml">defaults/main.yml</a></td>
<td></td>
<td>Download archive sha256 checksum for cache during (re)install.</td>
</tr>
<tr class="even">
<td>confluence_connector_port</td>
<td>yes</td>
<td>8090</td>
<td></td>
<td>Confluence Apache Tomcat connector port.</td>
</tr>
<tr class="odd">
<td>confluence_context_path</td>
<td>no</td>
<td><code>null</code></td>
<td></td>
<td>Pass value as <code>path</code> to <a href="https://github.com/pantarei/ansible-role-confluence/blob/master/templates/usr/share/confluence/conf/server.xml.j2">template</a>.</td>
</tr>
<tr class="even">
<td>confluence_gid</td>
<td>no</td>
<td></td>
<td></td>
<td>Specifying the GID for shared storage. NOTE: This value should only be set once before deploying and then never changed.</td>
</tr>
<tr class="odd">
<td>confluence_hash_salt</td>
<td>yes</td>
<td></td>
<td></td>
<td>Specific password hash salt for sha512.</td>
</tr>
<tr class="even">
<td>confluence_home</td>
<td>yes</td>
<td>/var/lib/confluence</td>
<td></td>
<td>Location for the Confluence home directory.</td>
</tr>
<tr class="odd">
<td>confluence_jvm_maximum_memory</td>
<td>yes</td>
<td>1024m</td>
<td></td>
<td>Confluence JVM maximum memory usage.</td>
</tr>
<tr class="even">
<td>confluence_jvm_minimum_memory</td>
<td>yes</td>
<td>512m</td>
<td></td>
<td>Confluence JVM minimum memory usage.</td>
</tr>
<tr class="odd">
<td>confluence_jvm_support_recommended_args</td>
<td>no</td>
<td><a href="https://github.com/pantarei/ansible-role-confluence/blob/master/defaults/main.yml">defaults/main.yml</a></td>
<td></td>
<td>Atlassian Support recommended JVM arguments.</td>
</tr>
<tr class="even">
<td>confluence_pass</td>
<td>yes</td>
<td></td>
<td></td>
<td>Password for Confluence system user.</td>
</tr>
<tr class="odd">
<td>confluence_proxy_name</td>
<td>no</td>
<td><code>null</code></td>
<td></td>
<td>Pass value as <code>proxyName</code> to <a href="https://github.com/pantarei/ansible-role-confluence/blob/master/templates/usr/share/confluence/conf/server.xml.j2">template</a>.</td>
</tr>
<tr class="even">
<td>confluence_scheme</td>
<td>no</td>
<td><code>null</code></td>
<td><ul>
<li><code>null</code></li>
<li>http</li>
<li>https</li>
</ul></td>
<td>Install Confluence in standalone mode if <code>null</code>, or integrating with Apache using HTTP if <code>http</code>, or integrating with Apache using HTTPS if <code>https</code>.</td>
</tr>
<tr class="odd">
<td>confluence_server_port</td>
<td>yes</td>
<td>8000</td>
<td></td>
<td>Confluence Apache Tomcat server port.</td>
</tr>
<tr class="even">
<td>confluence_uid</td>
<td>no</td>
<td></td>
<td></td>
<td>Specifying the UID for shared storage. NOTE: This value should only be set once before deploying and then never changed.</td>
</tr>
<tr class="odd">
<td>confluence_url</td>
<td>yes</td>
<td><a href="https://github.com/pantarei/ansible-role-confluence/blob/master/defaults/main.yml">defaults/main.yml</a></td>
<td></td>
<td>URL for download archive.</td>
</tr>
<tr class="even">
<td>confluence_user</td>
<td>yes</td>
<td></td>
<td></td>
<td>Username for Confluence system user.</td>
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
        - role: hswong3i.confluence
          confluence_hash_salt: "faiw8Wa8iyohx8Bo"
          confluence_pass: "ahle4Boo"
          confluence_user: "confluence"

License
-------

-   Code released under [MIT](https://github.com/pantarei/ansible-role-confluence/blob/master/LICENSE)
-   Docs released under [CC BY 4.0](http://creativecommons.org/licenses/by/4.0/)

Author Information
------------------

-   Wong Hoi Sing Edison
    -   <a href="https://twitter.com/hswong3i" class="uri" class="uri">https://twitter.com/hswong3i</a>
    -   <a href="https://github.com/hswong3i" class="uri" class="uri">https://github.com/hswong3i</a>

