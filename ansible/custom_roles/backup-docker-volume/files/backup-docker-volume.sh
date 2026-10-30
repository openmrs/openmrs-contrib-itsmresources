#!/bin/bash
# Archives the contents of a Docker volume into /opt/backups, where the nightly
# backup-upload.sh ships it to S3. The volume is read in place while its containers keep
# running, so this suits files that are not being rewritten mid-backup; use a
# database-specific dump (e.g. backup-postgres-docker.sh) for databases.
#
# Usage: backup-docker-volume.sh <name> <volume>
set -euo pipefail

NAME="$1"
VOLUME="$2"

OUT_DIR="/opt/backups"
OUT="${OUT_DIR}/${NAME}-$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

MOUNTPOINT="$(docker volume inspect --format '{{ .Mountpoint }}' "${VOLUME}")"

# Written under a dot-name and renamed once complete, so a failed archive never leaves a
# truncated file for the uploader.
TMP="$(mktemp "${OUT_DIR}/.${NAME}.XXXXXX")"
trap 'rm -f "${TMP}"' EXIT

tar --numeric-owner -czf "${TMP}" -C "${MOUNTPOINT}" .

# The uploader runs as the owner of OUT_DIR and must be able to read and delete the file.
chown --reference="${OUT_DIR}" "${TMP}"
mv "${TMP}" "${OUT}"
echo "Wrote ${OUT}"
