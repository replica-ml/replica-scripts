#!/bin/sh

if [ -n "$ZSH_VERSION" ] || [ -n "$BASH_VERSION" ]; then
  set -euo pipefail
fi

DIR="$( dirname -- "$( readlink -nf -- "$0" )")"
SCRIPT_ROOT_DIR="${SCRIPT_ROOT_DIR:-$( dirname -- "$( dirname -- "$( dirname -- "$0" )" )" )}"

"$SCRIPT_ROOT_DIR"'/conf.env.sh'

# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/conf.env.sh'

# shellcheck disable=SC1091
. "$DIR"'/conf.env.sh'

# shellcheck disable=SC1091
. "$SCRIPT_ROOT_DIR"'/_lib/_common/common.sh'

if ! cmd_avail python; then
  # shellcheck disable=SC1091
  . "$SCRIPT_ROOT_DIR"'/_lib/_toolchain/python/setup.sh'
fi

get_priv

"$PRIV" mkdir -p "${JUPYTER_NOTEBOOK_DIR}"
"$PRIV" chown -R "$JUPYTER_NOTEBOOK_SERVICE_USER":"$JUPYTER_NOTEBOOK_SERVICE_GROUP" "${JUPYTER_NOTEBOOK_DIR}"

if [ -d '/etc/systemd/system' ]; then
  [ -d '/home/'"$JUPYTER_NOTEBOOK_SERVICE_USER"'/' ] || adduser "$JUPYTER_NOTEBOOK_SERVICE_USER" --home '/home/'"$JUPYTER_NOTEBOOK_SERVICE_USER"'/' --gecos ''

  service_name='jupyter_notebook'"${JUPYTER_NOTEBOOK_PORT}"'_'"${JUPYTER_NOTEBOOK_PORT}"
  service='/etc/systemd/system/'"${service_name}"'.service'
  "$PRIV" envsubst < "$DIR"'/conf/systemd/jupyter_notebook.service' > "$service"
  "$PRIV" chmod 0644 "$service"
  "$PRIV" systemctl stop "$service" || true
  "$PRIV" systemctl daemon-reload
  "$PRIV" systemctl start "$service"
elif [ -d '/Library/LaunchDaemons' ]; then
  >&2 echo 'TODO: macOS service'
  exit 3
else
  "${JUPYTER_NOTEBOOK_VENV}"'/bin/jupyter' notebook \
    --NotebookApp.notebook_dir="${JUPYTER_NOTEBOOK_DIR}" \
    --NotebookApp.ip="${JUPYTER_NOTEBOOK_IP}" \
    --NotebookApp.port="${JUPYTER_NOTEBOOK_PORT}" \
    --Session.username="${JUPYTER_NOTEBOOK_USERNAME}" \
    --NotebookApp.password="${JUPYTER_NOTEBOOK_PASSWORD}" \
    --NotebookApp.password_required=True \
    --NotebookApp.allow_remote_access=True \
    --NotebookApp.iopub_data_rate_limit=2147483647 \
    --no-browser \
    --NotebookApp.open_browser=False &
fi
