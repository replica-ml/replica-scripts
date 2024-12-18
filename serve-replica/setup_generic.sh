#!/bin/sh

if [ -n "$ZSH_VERSION" ] || [ -n "$BASH_VERSION" ]; then
  set -euo pipefail
fi

previous_wd="$(pwd)"
ROOT="$( dirname -- "$( dirname -- "$( readlink -nf -- "$0" )" )" )"
SCRIPT_ROOT_DIR="${SCRIPT_ROOT_DIR:-$ROOT}"

# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/conf.env.sh'
# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/_common/common.sh'
# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/_git/git.sh'

# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/_rust/rust.sh'

ensure_available git

target="$BUILD_DIR"'/serve-replica'
git_get https://github.com/replica-ml/serve-replica "$target"
# shellcheck disable=SC2164
cd "$target"
cargo build --release

# shellcheck disable=SC2164
cd "${previous_wd}"
