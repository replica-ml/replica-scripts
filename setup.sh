#!/bin/sh

if [ -n "$ZSH_VERSION" ] || [ -n "$BASH_VERSION" ]; then
  set -euo pipefail
fi

DIR="$( dirname -- "$( readlink -nf -- "$0" )")"
export DIR

UNAME="$(uname)"
export UNAME
case "$UNAME" in
  'Darwin')
    export PKG_MGR='brew'
    export HOMEBREW_INSTALL="${HOMEBREW_INSTALL:-1}"
    export NGINX_SERVERS_ROOT='/opt/homebrew/etc/nginx/servers'
    [ -f '/opt/homebrew/bin/brew' ] || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    TARGET_OS="$(sw_vers --productName)"
    ;;
  'Linux')
    ID="$(. /etc/os-release; printf '%s' "$ID")"
    ID_LIKE="$(. /etc/os-release; printf '%s' "$ID_LIKE")"
    export NGINX_SERVERS_ROOT='/etc/nginx/conf.d/sites-available'
    case "$ID" in
      'alpine') export PKG_MGR='apk' ;;
      'debian') export PKG_MGR='apt-get' ;;
      'rhel') export PKG_MGR='dnf' ;;
      *)
        case "$ID_LIKE" in
          *debian*) export PKG_MGR='apt-get' ;;
          *rhel*) export PKG_MGR='dnf' ;;
          *) ;;
        esac
      ;;
    esac
    case "$PKG_MGR" in
      'apk')
        TARGET_OS='alpine'
        ;;
      'apt-get')
        TARGET_OS='debian'
        export DEBIAN_FRONTEND='noninteractive' ;;
      'dnf')
        TARGET_OS='rhel'
        ;;
      *)
        >&2 printf 'Unimplemented, package manager for %s\n' "$TARGET_OS"
        exit 3
        ;;
    esac
    ;;
  *)
    >&2 printf 'Unimplemented for %s\n' "$UNAME"
    exit 3
    ;;
esac
export TARGET_OS

# shellcheck source=conf.env.sh
# shellcheck disable=SC1091
. "$DIR"'/conf.env.sh'

if [ "$POSTGRESQL_INSTALL" -eq 1 ]; then
  "$DIR"'/postgres/setup_'"${TARGET_OS}"'.sh'
fi
if [ -n "$DATABASE_URL" ]; then 
  >&2 printf 'DATABASE_URL must be set\n';
  exit 3
fi

if [ "$VALKEY_INSTALL" -eq 1 ]; then
  "$DIR"'/valkey/setup_'"${TARGET_OS}"'.sh'
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
  "$DIR"'/nginx/setup_'"${TARGET_OS}"'.sh'
fi

# uses `WWWROOT`
if [ "$WWWROOT_INSTALL" -eq 1 ]; then
  "$DIR"'/replica-ng/setup.sh'
fi

# uses `FACESWAPPER_VENV`
if [ "$FACESWAPPER_INSTALL" -eq 1 ]; then
  "$DIR"'/faceswapper/setup_'"${TARGET_OS}"'.sh'
fi

# uses `REDIS_URL` and `DATABASE_URL`
"$DIR"'/serve-replica/setup.sh'

# uses `FACESWAPPER_VENV` and `REDIS_URL`
"$DIR"'/celery/setup_'"${TARGET_OS}"'.sh'
