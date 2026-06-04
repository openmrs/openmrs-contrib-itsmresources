# aws-cli

Installs the AWS CLI and writes `~/.aws/{config,credentials}` from the `profiles` variable.

Vendored from the Galaxy role [`badpacketsllc.aws_cli`](https://galaxy.ansible.com/badpacketsllc/aws_cli)
(Apache-2.0; see `LICENSE` / `AUTHORS`). The original variables and behaviour are unchanged;
we added AWS CLI **v2** support because Ubuntu dropped the `awscli` apt package in 24.04
(noble), where the upstream role's `package: awscli` install fails.

## Install method

`aws_cli_use_v2_installer` (default: true on Ubuntu >= 24) selects between:

- **apt** (`awscli`) — the upstream path, used on releases that still ship the package.
- **AWS CLI v2** — Amazon's official installer, run via `/usr/local/sbin/awscli-v2-install.sh`
  (the same script the weekly update cron uses, so install and update share one source of
  truth). It has no package manager behind it, so `aws_cli_v2_auto_update` (default true)
  installs a weekly cron that re-runs the installer with `--update` to replace what
  unattended-upgrades used to do for the apt package.

`aws_cli_bin` records where the binary lands (`/usr/bin/aws` for apt, `/usr/local/bin/aws`
for v2); consumers such as `backup-upload.sh` reference it rather than assuming a path.

See `defaults/main.yml` for all variables.
