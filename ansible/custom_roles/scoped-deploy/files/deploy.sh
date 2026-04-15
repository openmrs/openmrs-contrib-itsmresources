#!/usr/bin/env bash
set -euo pipefail

# Scoped SSH deploy entry point.
# Invoked via forced command in authorized_keys — the actual command
# the SSH client sent is in SSH_ORIGINAL_COMMAND.

read -ra ARGS <<< "${SSH_ORIGINAL_COMMAND:-}"

usage() {
  cat >&2 <<'EOF'
Usage: deploy <stack> [options]

Options:
  --destroy-volumes          Destroy and recreate volumes
  --no-health-check          Skip waiting for containers to become healthy
  --health-check-timeout=N   Health check timeout in seconds (default: 300)
EOF
  exit 1
}

if [[ ${#ARGS[@]} -eq 0 ]]; then
  usage
fi

COMMAND="${ARGS[0]}"

case "$COMMAND" in
  deploy)
    STACK="${ARGS[1]:-}"
    if [[ -z "$STACK" ]]; then
      usage
    fi

    if [[ ! "$STACK" =~ ^[a-zA-Z0-9_-]+$ ]]; then
      echo "Invalid stack name: $STACK" >&2
      exit 1
    fi

    DESTROY_VOLUMES="false"
    HEALTH_CHECK="true"
    HEALTH_CHECK_TIMEOUT="300"

    for arg in "${ARGS[@]:2}"; do
      case "$arg" in
        --destroy-volumes)
          DESTROY_VOLUMES="true"
          ;;
        --no-health-check)
          HEALTH_CHECK="false"
          ;;
        --health-check-timeout=*)
          HEALTH_CHECK_TIMEOUT="${arg#*=}"
          if [[ ! "$HEALTH_CHECK_TIMEOUT" =~ ^[0-9]+$ ]]; then
            echo "Invalid timeout: $HEALTH_CHECK_TIMEOUT" >&2
            exit 1
          fi
          ;;
        *)
          echo "Unknown option: $arg" >&2
          usage
          ;;
      esac
    done

    export HEALTH_CHECK_ENABLED="$HEALTH_CHECK"
    export HEALTH_CHECK_TIMEOUT
    exec sudo /usr/local/bin/deploy-compose "$STACK" "$DESTROY_VOLUMES"
    ;;
  *)
    echo "Unknown command: $COMMAND" >&2
    usage
    ;;
esac
