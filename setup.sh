#!/bin/sh

export TARGET_OS='debian'
export WWWROOT=
export FACESWAPPER_VENV=

# If you skip this step, set env var `DATABASE_URL`
./postgres/"setup_${TARGET_OS}.sh"
# If you skip this step, set env var `REDIS_URL`
./valkey/"setup_${TARGET_OS}.sh"

./rust/setup.sh
./nodejs/setup.sh

./nginx/"setup_${TARGET_OS}.sh"

./replica-ng/setup.sh                  # uses `WWWROOT`
./faceswapper/"setup_${TARGET_OS}.sh"  # uses `FACESWAPPER_VENV`
./serve-replica/setup.sh               # uses `REDIS_URL` and `DATABASE_URL`
./celery/"setup_${TARGET_OS}.sh"       # uses `FACESWAPPER_VENV` and `REDIS_URL`
