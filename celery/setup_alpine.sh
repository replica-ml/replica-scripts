#!/usr/bin/env bash

if [ -n "$ZSH_VERSION" ] || [ -n "$BASH_VERSION" ]; then
  set -euo pipefail
fi

ROOT="$( dirname -- "$( dirname -- "$( readlink -nf -- "$0" )" )" )"
SCRIPT_ROOT_DIR="${SCRIPT_ROOT_DIR:-$ROOT}"

# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/conf.env.sh'

mkdir -p /var/{run,log}/celery
adduser celery --home /home/celery/
chown -R celery:celery /var/{run,log}/celery