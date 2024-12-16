#!/bin/sh

export UNAME="$(uname)"
case "$UNAME" in
  'Darwin')
    export PKG_MGR='brew'
    TARGET_OS="$(sw_vers --productName)"
    ;;
  'Linux')
    TARGET_OS="$(source /etc/os-release; printf '%s' "$ID")"
    if [ "$TARGET_OS" = 'debian' ] \
     || [ "$(source /etc/os-release; printf '%s' "$ID_LIKE")" = 'debian' ]; then
       export PKG_MGR='apt'
    else
      >&2 printf 'Unimplemented, package manager for %s\n' "$TARGET_OS"
      exit 3
    fi
    ;;
  *)
    >&2 printf 'Unimplemented for %s\n' "$UNAME"
    exit 3
    ;;
esac
export TARGET_OS

export WWWROOT=
export FACESWAPPER_VENV=

export

# If you skip this step, set env var `DATABASE_URL`
./postgres/"setup_${TARGET_OS}.sh"
# If you skip this step, set env var `REDIS_URL`
./valkey/"setup_${TARGET_OS}.sh"

./rust/setup.sh
./nodejs/setup.sh
./python/setup.sh

./nginx/"setup_${TARGET_OS}.sh"

./replica-ng/setup.sh                  # uses `WWWROOT`
./faceswapper/"setup_${TARGET_OS}.sh"  # uses `FACESWAPPER_VENV`
./serve-replica/setup.sh               # uses `REDIS_URL` and `DATABASE_URL`
./celery/"setup_${TARGET_OS}.sh"       # uses `FACESWAPPER_VENV` and `REDIS_URL`
