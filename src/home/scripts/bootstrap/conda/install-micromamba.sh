#!/bin/bash

set -eux
bash --version

ARGS=(
  home_abspath
  environment_name
  mamba_root_prefix
)
. ${0%/*}/../linux/parse-args.sh

# micromamba_abspath="${home_abspath}/bin/micromamba"
export MAMBA_ROOT_PREFIX=$mamba_root_prefix

# cd ${home_abspath}

wget -O - https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba

eval "$(./bin/micromamba shell hook -s posix)"

./bin/micromamba  shell init -s bash -r ${home_abspath}/micromamba  # this writes to your .bashrc file
# echo "alias mm=${home_abspath}" >> "${home_abspath}/.bash_aliases"

source ${home_abspath}/.bashrc

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

which pip

pip install -r ${home_abspath}/requirements.txt

pip list -v

micromamba list
