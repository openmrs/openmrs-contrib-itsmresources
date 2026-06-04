# acme-dns

Deploys a self-hosted [acme-dns](https://github.com/acme-dns/acme-dns) server (the `chiro`
host) used for DNS-01 ACME challenges. Cert hosts delegate `_acme-challenge.<name>` to this
server via a static CNAME and hold an isolated, write-scoped account per name, so a
compromised web server can never touch real DNS.

## What it does

- Templates `config.cfg` and a `docker-compose.yml`, then brings the container up with the
  repo's standard `deploy-compose` script (the host must be in the `[docker]` group, which
  installs that script). A `deploy.env` sets `DESTROY_VOLUMES=false` so the sqlite accounts
  DB is never torn down.
- Opens `53/tcp` + `53/udp` to the world and the HTTP API port (`8080`) only from the
  private subnet via `ufw` (defence-in-depth behind the OpenStack security group).
- Stages a nightly online snapshot of the accounts DB into `/opt/backups` so the existing
  `backup-upload.sh` ships it to S3 (the host must be in the `[backup]` group).

## Required variables

- `acme_dns_public_ip` — chiro's **public floating IP** (Terraform `chiro` output
  `ip_address`). Must be set in `host_vars`; it cannot be derived from facts. acme-dns
  advertises it in the A records it serves.

See `defaults/main.yml` for the rest. After all accounts are registered, set
`acme_dns_disable_registration: true` to close public registration.

## Operational notes

- The accounts DB (`{{ acme_dns_data_dir }}/acme-dns.db`) is critical: it maps accounts to
  their `<uuid>.acme.openmrs.org` subdomains. Losing it forces re-registration of every
  account and rewriting every `_acme-challenge` CNAME. It is backed up to S3; restore it
  before re-running on a rebuilt host.
