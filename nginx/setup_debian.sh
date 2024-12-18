#!/usr/bin/env bash

if [ -n "$ZSH_VERSION" ] || [ -n "$BASH_VERSION" ]; then
  set -euo pipefail
fi

ROOT="$( dirname -- "$( dirname -- "$( readlink -nf -- "$0" )" )" )"
SCRIPT_ROOT_DIR="${SCRIPT_ROOT_DIR:-$ROOT}"

# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/conf.env.sh'
# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/_apt/apt.sh'

apt_depends curl gnupg2 ca-certificates lsb-release debian-archive-keyring
[ -f '/usr/share/keyrings/nginx-archive-keyring.gpg' ] || \
  curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
[ -f '/etc/apt/sources.list.d/nginx.list' ] || \
  echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
  http://nginx.org/packages/debian $(lsb_release -cs) nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list
[ -f '/etc/apt/preferences.d/99nginx' ] || \
  echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
    | sudo tee /etc/apt/preferences.d/99nginx && \
  sudo apt update -qq

apt_depends nginx
