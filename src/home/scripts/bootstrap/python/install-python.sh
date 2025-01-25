#!/bin/bash

set -euxo pipefail
bash --version

ARGS=(
  home_abspath
  python_version
  venv_path
)
. /home/dev/scripts/utils/parse-args.sh

add-apt-repository ppa:deadsnakes/ppa
apt-get update

apt-get install -y python${python_version}

ln -sf $(which python3.13) /usr/bin/python

python --version

python -m venv --without-pip ${venv_path}
echo "source ${venv_path}/bin/activate" >> ${home_abspath}/.bashrc

source ${venv_path}/bin/activate

wget -O - https://bootstrap.pypa.io/get-pip.py | python
pip --version

pip install --require-virtualenv -r "${home_abspath}/requirements.txt"
