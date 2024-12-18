#!/bin/sh

if [ -n "$ZSH_VERSION" ] || [ -n "$BASH_VERSION" ]; then
  set -euo pipefail
fi

previous_wd="$(pwd)"
ROOT="$( dirname -- "$( dirname -- "$( readlink -nf -- "$0" )" )" )"
SCRIPT_ROOT_DIR="${SCRIPT_ROOT_DIR:-$ROOT}"

# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/conf.env.sh'

case "$PKG_MGR" in
  'apk') apk add git ;;
  'apt-get') apt_depends git ;;
  'dnf') dnf install git ;;
  *) >&2 printf 'Unimplemented, package manager %s\n' "$PKG_MGR"
esac

target="$BUILD_DIR"'/serve-replica'
mkdir -p "$target"
git clone --depth=1 --single-branch https://github.com/replica-ml/serve-replica "$target"
# shellcheck disable=SC2164
cd "$target"
cargo build --release

# shellcheck disable=SC2164
cd "${previous_wd}"
