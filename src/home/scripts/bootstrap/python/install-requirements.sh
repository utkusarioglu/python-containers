#!/bin/bash

ARGS=(
  home_abspath
  venv_path
)
. ${0%/*}/parse-args.sh

source ${venv_path}/bin/activate
pip install --require-virtualenv -r "${home_abspath}/requirements.txt"
