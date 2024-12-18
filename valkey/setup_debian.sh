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
. "$SCRIPT_ROOT_DIR"'/_apt/apt.sh'
# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/_git/git.sh'

apt_depends git build-essential libsystemd-dev

target="$BUILD_DIR"'/valkey'
git_get https://github.com/valkey-io/valkey "$target"
# shellcheck disable=SC2164
cd "$target"
make BUILD_TLS='yes' USE_SYSTEMD='yes'
sudo make install

# shellcheck disable=SC2164
cd "${previous_wd}"
