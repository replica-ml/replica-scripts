#!/bin/sh

if [ -n "$ZSH_VERSION" ] || [ -n "$BASH_VERSION" ]; then
  set -euo pipefail
fi

DIR="$( dirname -- "$( readlink -nf -- "$0" )")"
export DIR

ROOT="$( dirname -- "$( dirname -- "$( readlink -nf -- "$0" )" )" )"
export SCRIPT_ROOT_DIR="${SCRIPT_ROOT_DIR:-$ROOT}"

"$SCRIPT_ROOT_DIR"'/setup_'"${TARGET_OS}"'.sh'
