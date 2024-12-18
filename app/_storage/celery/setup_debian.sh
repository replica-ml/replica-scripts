#!/usr/bin/env bash

if [ -n "$ZSH_VERSION" ] || [ -n "$BASH_VERSION" ]; then
  set -veuo pipefail
fi

SCRIPT_ROOT_DIR="${SCRIPT_ROOT_DIR:-$( dirname -- "$( dirname -- "$( dirname -- "$0" )" )" )}"

# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/conf.env.sh'
# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/_lib/_os/_apt/apt.sh'

get_priv

"$PRIV" mkdir /var/{run,log}/celery
"$PRIV" adduser celery --home /home/celery/
"$PRIV" chown -R celery:celery /var/{run,log}/celery
