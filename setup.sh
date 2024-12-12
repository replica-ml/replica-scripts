#!/bin/sh

export WWWROOT=
export FACESWAPPER_VENV=

# If you skip this step, set env var `DATABASE_URL`
./postgres/setup.sh
# If you skip this step, set env var `REDIS_URL`
./valkey/setup.sh

./rust/setup.sh
./nodejs/setup.sh

./nginx/setup.sh

./replica-ng/setup.sh     # uses `WWWROOT`
./faceswapper/setup.sh    # uses `FACESWAPPER_VENV`
./serve-replica/setup.sh  # uses `REDIS_URL` and `DATABASE_URL`
./celery/setup.sh         # uses `REDIS_URL`
