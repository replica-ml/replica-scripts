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
. "$SCRIPT_ROOT_DIR"'/_lib/_git/git.sh'

target="$BUILD_DIR"'/firecrawl'
git_get https://github.com/mendableai/firecrawl "$target"
# shellcheck disable=SC2164
cd "$target"'/apps/api'
cp ../../../../conf/.env .

# shellcheck disable=SC2164
cd "${previous_wd}"
