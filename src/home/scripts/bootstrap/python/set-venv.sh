#!/bin/bash

set -eux

ARGS=(
  venv_path
)
. ${0%/*}/parse-args.sh

python -m venv ${venv_path}
echo "source ${venv_path}/bin/activate" >> ~/.bashrc
