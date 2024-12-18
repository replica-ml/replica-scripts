#!/usr/bin/env bash

if [ -n "$ZSH_VERSION" ] || [ -n "$BASH_VERSION" ]; then
  set -euo pipefail
fi

SCRIPT_ROOT_DIR="${SCRIPT_ROOT_DIR:-$( dirname -- "$( dirname -- "$( dirname -- "$0" )" )" )}"

# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/conf.env.sh'
# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/_lib/_os/_apt/apt.sh'

get_priv

apt_depends postgresql-common
"$PRIV" /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
apt_depends postgresql-server-dev-"$POSTGRESQL_VERSION" postgresql-"$POSTGRESQL_VERSION"
