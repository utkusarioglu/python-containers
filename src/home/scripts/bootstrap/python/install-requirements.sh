#!/bin/bash

set -euxo pipefail
bash --version

ARGS=(
  home_abspath
  venv_path
)
. /home/dev/scripts/utils/parse-args.sh

source ${venv_path}/bin/activate
