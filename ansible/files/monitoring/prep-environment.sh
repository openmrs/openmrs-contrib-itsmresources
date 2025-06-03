#!/bin/bash

set -eux

OS_FULL_VERSION=$(fgrep "PRETTY_NAME"  /etc/os-release | sed -E "s/.*Ubuntu ([0-9.]*) .*/\1/" || echo "Unknown")
DOCKER_VERSION=$(docker --version  | sed -E "s/.*version ([0-9.]*),.*/\1/" || echo "Unknown")
PYTHON_VERSION=$(python3 --version | sed -E "s/.*Python ([0-9.]*).*/\1/" || echo "Unknown")

echo "## Updated by datadog service $(date)" > /etc/datadog-agent/environment
echo "DD_EXTRA_TAGS=UBUNTU_VERSION:${OS_FULL_VERSION} DOCKER_VERSION:${DOCKER_VERSION} PYTHON_VERSION:${PYTHON_VERSION}" >> /etc/datadog-agent/environment