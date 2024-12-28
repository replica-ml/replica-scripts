#!/bin/sh

if [ -n "${ZSH_VERSION}" ] || [ -n "${BASH_VERSION}" ]; then
  set -euo pipefail
fi

SCRIPT_ROOT_DIR="${SCRIPT_ROOT_DIR:-$( dirname -- "$( dirname -- "$( dirname -- "${0}" )" )" )}"

# shellcheck disable=SC1091
. "${SCRIPT_ROOT_DIR}"'/conf.env.sh'

mkdir -p /var/run/celery /var/log/celery
[ -d '/home/celery' ] || adduser celery --home /home/celery/ --gecos ''
chown -R celery:celery /var/run/celery /var/log/celery
