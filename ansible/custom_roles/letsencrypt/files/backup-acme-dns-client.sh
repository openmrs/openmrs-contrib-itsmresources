#!/bin/bash
# Stage the acme-dns client account store into /opt/backups so the nightly backup-upload.sh
# ships it to S3. clientstorage.json maps each cert name to its acme-dns account and the
# stable <uuid>.acme.openmrs.org subdomain; losing it forces re-registration and rewriting
# every _acme-challenge CNAME, so it must survive a host rebuild.
set -euo pipefail

SRC="${1:-/etc/acmedns/clientstorage.json}"
OUT_DIR="/opt/backups"
OUT="${OUT_DIR}/clientstorage.json"

mkdir -p "${OUT_DIR}"

if [[ ! -f "${SRC}" ]]; then
  echo "acme-dns client storage not found at ${SRC}" >&2
  exit 1
fi

# 0644 matches the other staged backups (root-created, read by the backup user on upload).
install -m 0644 "${SRC}" "${OUT}"
