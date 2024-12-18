#!/bin/sh

ROOT="$( dirname -- "$( dirname -- "$( readlink -nf -- "$0" )" )" )"
SCRIPT_ROOT_DIR="${SCRIPT_ROOT_DIR:-$ROOT}"

#DIR="$( dirname -- "$( readlink -nf -- "$0" )")"
# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/_common/os_info.sh'

ensure_available() {
  case "$PKG_MGR" in
    'apk') apk add "$0" ;;
    'apt-get') apt_depends "$0" ;;
    'dnf') dnf install "$0" ;;
    *) >&2 printf 'Unimplemented, package manager %s\n' "$PKG_MGR"
  esac
}
