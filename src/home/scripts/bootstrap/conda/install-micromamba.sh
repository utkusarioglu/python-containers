#!/bin/bash

set -eux
bash --version

ARGS=(
  home_abspath
  environment_name
  mamba_root_prefix
)
. ${0%/*}/../linux/parse-args.sh

export MAMBA_ROOT_PREFIX=$mamba_root_prefix

wget -O - https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba

mv bin/micromamba /usr/bin/micromamba

eval "$(/usr/bin/micromamba shell hook -s posix --rc-file ${home_abspath}/.bashrc)"

/usr/bin/micromamba shell init \
  -s bash \
  -r /usr/bin/micromamba \
  --rc-file ${home_abspath}/.bashrc
echo "alias mm=micromamba" >> "${home_abspath}/.bash_aliases"

source ${home_abspath}/.bashrc
# source ${home_abspath}/.bash_aliases

micromamba --version
# THIS NEEDS TO WORK
# mm --version

yq eval-all \
  '. as $item ireduce ({}; . *+ $item)' \
  "${home_abspath}/environment.common.yml" \
  "${home_abspath}/environment.repo.yml" \
  > "${home_abspath}/environment.merged.yml"

echo "Common:"
cat "${home_abspath}/environment.common.yml"

echo "Repo:"
cat "${home_abspath}/environment.repo.yml"

echo "Merged:"
cat "${home_abspath}/environment.merged.yml"

micromamba env create --file "${home_abspath}/environment.merged.yml" 

micromamba activate ${environment_name}

which pip

pip install -r ${home_abspath}/requirements.txt

pip list -v

micromamba list
