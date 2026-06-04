#!/bin/bash
# Stage a consistent snapshot of the acme-dns sqlite accounts DB into /opt/backups so the
# nightly backup-upload.sh ships it to S3. The DB maps accounts -> subdomains; losing it
# forces re-registration of every account and rewriting every _acme-challenge CNAME, so it
# must survive a host rebuild. `.backup` (rather than cp) takes a safe online snapshot.
set -euo pipefail

DB="${1:-/var/lib/acme-dns/acme-dns.db}"
OUT_DIR="/opt/backups"
OUT="${OUT_DIR}/acme-dns.db"

mkdir -p "${OUT_DIR}"

if [[ ! -f "${DB}" ]]; then
  echo "acme-dns DB not found at ${DB}" >&2
  exit 1
fi

sqlite3 "${DB}" ".backup '${OUT}'"
