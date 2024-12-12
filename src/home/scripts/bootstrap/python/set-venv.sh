#!/bin/bash

set -eux

ARGS=(
  home_abspath
  venv_path
)
. ${0%/*}/../linux/parse-args.sh

python -m venv --without-pip ${venv_path}
echo "source ${venv_path}/bin/activate" >> ${home_abspath}/.bashrc

source ${venv_path}/bin/activate

wget -O - https://bootstrap.pypa.io/get-pip.py | python
pip --version
