#!/bin/sh

mkdir build
pushd build
git clone --depth=1 --single-branch https://github.com/mendableai/firecrawl
pushd firecrawl/apps/api
cp ../../../../conf/.env .
popd
popd
