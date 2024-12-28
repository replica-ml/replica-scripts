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
. "${SCRIPT_ROOT_DIR}"'/_lib/_common/common.sh'

# shellcheck disable=SC1091
. "${SCRIPT_ROOT_DIR}"'/_lib/_toolchain/nodejs/setup.sh'

if ! cmd_avail ng; then
    npm i -g @angular/cli
fi

target="${BUILD_DIR}"'/replica-ng'
git_get https://github.com/replica-ml/replica-ng "${target}"
cd "${target}"
ng build --configuration production
cd "${previous_wd}"
