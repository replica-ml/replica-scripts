#!/bin/sh

if [ -n "$ZSH_VERSION" ] || [ -n "$BASH_VERSION" ]; then
  set -euo pipefail
fi

SCRIPT_ROOT_DIR="${SCRIPT_ROOT_DIR:-$( dirname -- "$( dirname -- "$( dirname -- "$0" )" )" )}"

# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/conf.env.sh'

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain "$RUST_VERSION"
