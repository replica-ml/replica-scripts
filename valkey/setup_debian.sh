#!/bin/sh

sudo apt install git build-essential libsystemd-dev

mkdir build
pushd build
git clone --depth=1 --single-branch https://github.com/valkey-io/valkey
pushd valkey
make BUILD_TLS=yes USE_SYSTEMD=yes
sudo make install
popd
popd
