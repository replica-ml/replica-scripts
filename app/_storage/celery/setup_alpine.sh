#!/usr/bin/env bash

if [ -n "$ZSH_VERSION" ] || [ -n "$BASH_VERSION" ]; then
  set -euo pipefail
fi

SCRIPT_ROOT_DIR="${SCRIPT_ROOT_DIR:-$( dirname -- "$( dirname -- "$( dirname -- "$0" )" )" )}"

# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/conf.env.sh'

mkdir -p /var/{run,log}/celery
adduser celery --home /home/celery/
chown -R celery:celery /var/{run,log}/celery
