#!/usr/bin/env bash

if [ -n "$ZSH_VERSION" ] || [ -n "$BASH_VERSION" ]; then
  set -euo pipefail
fi

ROOT="$( dirname -- "$( dirname -- "$( readlink -nf -- "$0" )" )" )"
SCRIPT_ROOT_DIR="${SCRIPT_ROOT_DIR:-$ROOT}"

# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/conf.env.sh'
. "$SCRIPT_ROOT_DIR"'/_lib/_os/_apt/apt.sh'

apt_depends postgresql-common
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh
apt_depends postgresql-server-dev-"$POSTGRESQL_VERSION" postgresql-"$POSTGRESQL_VERSION"
