#!/bin/sh

set -v
guard='H_'"$(realpath -- "${0}" | sed 's/[^a-zA-Z0-9_]/_/g')"
if env | grep -qF "${guard}"; then return ; fi
export "${guard}"=1
if [ -n "${ZSH_VERSION}" ] || [ -n "${BASH_VERSION}" ]; then
  set -euo pipefail
fi

previous_wd="$(pwd)"
SCRIPT_ROOT_DIR="${SCRIPT_ROOT_DIR:-$( dirname -- "$( dirname -- "$( dirname -- "${0}" )" )" )}"

# shellcheck disable=SC1091
. "${SCRIPT_ROOT_DIR}"'/conf.env.sh'
# shellcheck disable=SC1091
. "${SCRIPT_ROOT_DIR}"'/_lib/_common/common.sh'
# shellcheck disable=SC1091
. "${SCRIPT_ROOT_DIR}"'/_lib/_git/git.sh'

# shellcheck disable=SC1091
. "${SCRIPT_ROOT_DIR}"'/_lib/_toolchain/rust/setup.sh'

ensure_available git

target="${BUILD_DIR}"'/serve-replica'
git_get https://github.com/replica-ml/serve-replica "${target}"
# shellcheck disable=SC2164
cd "${target}"
cargo build --release

# shellcheck disable=SC2164
cd "${previous_wd}"
