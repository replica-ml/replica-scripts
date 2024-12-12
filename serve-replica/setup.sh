#!/bin/sh

mkdir build
pushd build
git clone --depth=1 --single-branch https://github.com/replica-ml/serve-replica
cd serve-replica
cargo build --release
popd
popd
