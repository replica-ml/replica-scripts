#!/usr/bin/env bash

export DEBIAN_FRONTEND='noninteractive'

function is_installed() {
    dpkg-query --showformat='${Version}' --show "$1" 2>/dev/null
}

function apt_depends() {
   pkgs=("$@")
   declare -a pkgs2install=()
   for pkg in "${pkgs[@]}"; do
     if ! is_installed "${pkg}"; then
       pkgs2install+=( "${pkg}" )
     fi
   done
   sudo apt-get install -y "${pkgs2install[@]}"
}
