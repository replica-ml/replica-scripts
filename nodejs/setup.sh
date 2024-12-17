#!/bin/sh

if [ -n "$ZSH_VERSION" ] || [ -n "$BASH_VERSION" ]; then
  set -euo pipefail
fi

ROOT="$( dirname -- $( dirname -- $( readlink -nf -- "$0" ) ) )"
SCRIPT_ROOT_DIR="${SCRIPT_ROOT_DIR:-$ROOT}"

# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/conf.env.sh'

curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | sh bash -s install lts
npm i -g npm
