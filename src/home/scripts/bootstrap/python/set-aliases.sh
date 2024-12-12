#!/bin/bash

set -eux

ARGS=(
  home_abspath
  venv_path
)
. ${0%/*}/../linux/parse-args.sh

echo "alias elam=$elam_path/elam.sh" >> ${home_abspath}/.bash_aliases
. ${home_abspath}/.bash_aliases
