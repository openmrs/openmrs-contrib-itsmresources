# backup-postgres-docker

Nightly `pg_dump` of Postgres databases that run as Docker Compose services. Each dump lands
in `/opt/backups` as `<name>-<timestamp>.dump` (mode 0600, owned by the backup user) and is
shipped to `s3://openmrs-backups/<host>/` by the `backup-upload.sh` cron from
`tasks/backup.yml`, so the host must be in the `[backup]` group.

`pg_dump` runs inside the Postgres container over its local socket, which the official
`postgres` image trusts by default, so no credentials are needed here.

## Configuration

List databases in `host_vars`; see `defaults/main.yml` for the fields.

```yaml
backup_postgres_docker:
  - name: hermes-litellm
    compose_dir: /root/docker/hermes
    service: postgres
    user: litellm
    database: litellm
```

Output goes to `/home/<backup_user>/backups-<name>.log`.

## Restore

Dumps use pg_dump's custom format. Copy one from S3 to the host, then, with the stack's
other services stopped:

```sh
cd /root/docker/hermes
docker compose exec -T postgres pg_restore -U litellm -d litellm --clean --if-exists < hermes-litellm-<timestamp>.dump
```
