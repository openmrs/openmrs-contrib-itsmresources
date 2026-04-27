# ansible-letsencrypt
An ansible role to generate TLS certificates and get them signed by Let's Encrypt.

Currently attempts first to use the `webroot` authenticator, then if that fails to create certificates,
it will use the standalone authenticator. This is handy for generating certs on a fresh machine before
the web server has been configured or even installed.

# Supported platforms
- Debian Jessie
- Debian Stretch
- Debian Buster
- Ubuntu Xenial

On other platforms this role will try to install letsencrypt using pip, which is not officially supported and may break over upgrades at least.

If you test it on other platforms please let me know the results (positive or
otherwise) so I can document them here and/or fix the issue.

Requires Ansible >= 2.0

# Usage
First, read Let's Encrypt's TOS and EULA. Only proceed if you agree to them.

The following variables are available:

`letsencrypt_webroot_path` is the root path that gets served by your web server. Defaults to `/var/www`.

`letsencrypt_email` needs to be set to your email address. Let's Encrypt wants it. Defaults to `webmaster@{{ ansible_fqdn }}`. If you _really_ want to register without providing an email address, define the variabe `letsencrypt_no_email`.

`letsencrypt_rsa_key_size` allows to specify a size for the generated key.

`letsencrypt_cert_domains` is a list of domains you wish to get a certificate for. It defaults to a single item with the value of `{{ ansible_fqdn }}`.

`letsencrypt_install_directory` should probably be left alone, but if you set it, it will change where the letsencrypt program is installed.

`letsencrypt_renewal_command_args` adds arguments to certbot when it renews or issues a certificate, both via the cron renewal job and via this role's playbook-driven webroot/standalone tasks. For example, set it to `--renew-hook "systemctl reload nginx"` to reload the web server after every successful cert deploy regardless of which path triggered the renewal.

`letsencrypt_standalone_command_args` adds arguments to the standalone authentication method. This is mostly useful for specifying supported challenges, such as `--standalone-supported-challenges tls-sni-01` to limit the authentication to port 443 if something is already running on 80 or vice versa.

`letsencrypt_server` sets the alternative auth server if needed. For example, during tests it's set to `https://acme-staging.api.letsencrypt.org/directory` to use the staging server (far higher rate limits, but certs are not trusted). It is not set by default. When this variable's value differs from the ACME server recorded in the existing renewal config, the role automatically passes `--force-renewal` to certbot so the cert is reissued from the new server. The auto-detection only fires when `letsencrypt_server` is explicitly set; if you previously had it set and now want to drop back to the certbot default, see `letsencrypt_force_renewal` below.

`letsencrypt_force_renewal` (default `false`) injects `--force-renewal` into the certbot command. Use this as a one-shot override (e.g. `-e letsencrypt_force_renewal=true`) when you need to discard an existing cert and reissue without changing any other variable. The most common reason is unsetting `letsencrypt_server` after testing against the staging endpoint: the auto-detection cannot identify certbot's built-in default server, so a manual force is required for that switchback.

`ssl_certificate` and `ssl_certificate_key` symlinks the certificates to provided path if both are set.

The [Let's Encrypt client](https://github.com/letsencrypt/letsencrypt) will put the certificate and accessories in `/etc/letsencrypt/live/<first listed domain>/`. For more info, see the [Let's Encrypt documentation](https://letsencrypt.readthedocs.org/en/latest/using.html#where-are-my-certificates).

# Workflows

## Fresh host
Just run the master playbook against the host. The role's standalone
authenticator handles the case where nginx is not yet installed.

```
ansible-playbook -i inventories/<inv> site.yml --limit <host>
```

## Adding a domain to an existing certificate
Edit `letsencrypt_cert_domains` in the relevant `host_vars` (or
`group_vars`) file to include the new domain, then re-run only the TLS
play:

```
ansible-playbook -i inventories/<inv> site.yml --tags tls --limit <host>
```

Certbot's `--expand` flag (already part of `letsencrypt_command`) extends
the existing certificate in place. Nginx does not need to be stopped and
the cert does not need to be deleted first. Certbot is idempotent; if no
domains have changed and the cert is not near expiry, the play is a
no-op.

Prerequisite: the new domain must already resolve to the host and
nginx must be configured to serve it (so the ACME HTTP-01 challenge can
reach `/.well-known/acme-challenge/` over port 80).

## Emergency recovery
If the certificate state is corrupted (deleted certs, mismatched
renewal config, nginx wedged into an unbootable state), use
`ansible/remove-certs.yml` to wipe `/etc/letsencrypt` and start clean,
then re-run `site.yml`.

# Example Playbook
```
---
 - hosts: tls_servers
   user: root
   roles:
     - role: letsencrypt
       letsencrypt_webroot_path: /var/www/html
       letsencrypt_email: user@example.net
       letsencrypt_cert_domains:
        - www.example.net
        - example.net
       letsencrypt_renewal_command_args: '--renew-hook "systemctl restart nginx"'
```
