#!/bin/bash

set -eux
bash --version

ARGS=(
  home_abspath
  environment_name
)
. ${0%/*}/../linux/parse-args.sh

# source ${home_abspath}/.bashrc

micromamba activate ${environment_name}

which pip

pip install -r ${home_abspath}/requirements.txt

pip list -v

micromamba list
