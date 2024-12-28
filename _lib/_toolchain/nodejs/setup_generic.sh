#!/bin/sh

if [ -n "${ZSH_VERSION}" ] || [ -n "${BASH_VERSION}" ]; then
  set -euo pipefail
fi

SCRIPT_ROOT_DIR="${SCRIPT_ROOT_DIR:-$( dirname -- "$( dirname -- "$( dirname -- "${0}" )" )" )}"

# shellcheck disable=SC1091
. "${SCRIPT_ROOT_DIR}"'/conf.env.sh'

curl -fsSL https://raw.githubusercontent.com/tj/n/master/bin/n | sh bash -s install lts
npm i -g npm
