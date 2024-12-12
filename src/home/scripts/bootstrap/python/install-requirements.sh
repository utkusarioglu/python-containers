#!/bin/bash

set -eux

ARGS=(
  home_abspath
  venv_path
)
. ${0%/*}/../linux/parse-args.sh

source ${venv_path}/bin/activate
