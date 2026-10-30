#!/bin/bash
# Dumps a Postgres database running as a Docker Compose service into /opt/backups, where the
# nightly backup-upload.sh ships it to S3. The dump is in pg_dump's custom format; restore it
# with pg_restore. Connects over the container's local socket, so no password is needed.
#
# Usage: backup-postgres-docker.sh <name> <compose-dir> <service> <db-user> <database>
set -euo pipefail

NAME="$1"
COMPOSE_DIR="$2"
SERVICE="$3"
DB_USER="$4"
DATABASE="$5"

OUT_DIR="/opt/backups"
OUT="${OUT_DIR}/${NAME}-$(date +%Y-%m-%d_%H-%M-%S).dump"

if command -v docker-compose >/dev/null 2>&1; then
  DOCKER_COMPOSE=(docker-compose)
else
  DOCKER_COMPOSE=(docker compose)
fi

# Written under a dot-name and renamed once complete, so a failed dump never leaves a
# truncated file for the uploader.
TMP="$(mktemp "${OUT_DIR}/.${NAME}.XXXXXX")"
trap 'rm -f "${TMP}"' EXIT

cd "${COMPOSE_DIR}"
"${DOCKER_COMPOSE[@]}" exec -T "${SERVICE}" pg_dump -U "${DB_USER}" -Fc "${DATABASE}" > "${TMP}"

# The uploader runs as the owner of OUT_DIR and must be able to read and delete the file.
chown --reference="${OUT_DIR}" "${TMP}"
mv "${TMP}" "${OUT}"
echo "Wrote ${OUT}"
