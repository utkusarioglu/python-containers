#!/bin/bash

set -eux
bash --version

ARGS=(
  home_abspath
)
. ${0%/*}/../linux/parse-args.sh


pip install -r ${home_abspath}/requirements.txt

pip list -v

micromamba list
