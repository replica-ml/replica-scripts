#!/bin/sh

curl -LsSf https://astral.sh/uv/install.sh | sh

uv python install "$PYTHON_VERSION"
