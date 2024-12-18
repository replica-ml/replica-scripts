#!/bin/sh

if [ -n "$ZSH_VERSION" ] || [ -n "$BASH_VERSION" ]; then
  set -euo pipefail
fi

DIR="$( dirname -- "$( readlink -nf -- "$0" )")"
export DIR

ROOT="$( dirname -- "$( dirname -- "$( readlink -nf -- "$0" )" )" )"
export SCRIPT_ROOT_DIR="${SCRIPT_ROOT_DIR:-$ROOT}"

# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/_common/os_info.sh'

os_setup_script="$DIR"'/setup_'"${TARGET_OS}"'.sh'
if [ -f "$os_setup_script" ]; then
  # shellcheck disable=SC1090
  . "$os_setup_script"
else
  # shellcheck disable=SC1091
  . "$DIR"'/setup_generic.sh'
fi
