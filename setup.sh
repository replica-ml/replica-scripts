#!/bin/sh

if [ -n "$ZSH_VERSION" ] || [ -n "$BASH_VERSION" ]; then
  set -euo pipefail
fi

DIR="$( dirname -- "$( readlink -nf -- "$0" )")"
export DIR

# shellcheck disable=SC1091
. "$DIR"'/_common/os_info.sh'
# shellcheck disable=SC1091
. "$DIR"'/conf.env.sh'

if [ "$POSTGRESQL_INSTALL" -eq 1 ]; then
  "$DIR"'/postgres/setup.sh'
fi
if [ -n "$DATABASE_URL" ]; then 
  >&2 printf 'DATABASE_URL must be set\n';
  exit 3
fi

if [ "$VALKEY_INSTALL" -eq 1 ]; then
  "$DIR"'/valkey/setup.sh'
fi
if [ -n "$REDIS_URL" ]; then 
  >&2 printf 'REDIS_URL must be set\n';
  exit 3
fi

if [ "$RUST_INSTALL" -eq 1 ]; then
  "$DIR"'/rust/setup.sh'
fi
if [ "$NODEJS_INSTALL" -eq 1 ]; then
  "$DIR"'/nodejs/setup.sh'
fi
if [ "$PYTHON_INSTALL" -eq 1 ]; then
  "$DIR"'/python/setup.sh'
fi

if [ "$NGINX_INSTALL" -eq 1 ]; then
  "$DIR"'/nginx/setup.sh'
fi

# uses `WWWROOT`
if [ "$WWWROOT_INSTALL" -eq 1 ]; then
  "$DIR"'/replica-ng/setup.sh'
fi

# uses `FACESWAPPER_VENV`
if [ "$FACESWAPPER_INSTALL" -eq 1 ]; then
  "$DIR"'/faceswapper/setup.sh'
fi

# uses `REDIS_URL` and `DATABASE_URL`
"$DIR"'/serve-replica/setup.sh'

# uses `FACESWAPPER_VENV` and `REDIS_URL`
"$DIR"'/celery/setup.sh'
