# backup-docker-volume

Nightly `tar` of Docker volumes. Each archive lands in `/opt/backups` as
`<name>-<timestamp>.tar.gz` (mode 0600, owned by the backup user) and is shipped to
`s3://openmrs-backups/<host>/` by the `backup-upload.sh` cron from `tasks/backup.yml`, so the
host must be in the `[backup]` group.

Volumes are read in place while their containers run. That is fine for configuration and
other files that change rarely; databases need a consistent dump instead (see
`backup-postgres-docker`). If a file changes while it is being archived, `tar` fails and no
archive is written for that night.

## Configuration

List volumes in `host_vars`; see `defaults/main.yml` for the fields.

```yaml
backup_docker_volumes:
  - name: hermes-agents
    volume: hermes_agents-data
```

Output goes to `/home/<backup_user>/backups-<name>.log`.

## Restore

Archives keep numeric owners and permissions, and contain the volume's contents relative to
its root. Copy one from S3 to the host, stop the containers using the volume, then:

```sh
tar --numeric-owner -xzf hermes-agents-<timestamp>.tar.gz -C "$(docker volume inspect --format '{{ .Mountpoint }}' hermes_agents-data)"
```
