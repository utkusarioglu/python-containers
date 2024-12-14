#!/bin/bash

set -eux
bash --version

ARGS=(
  home_abspath
)
. ${0%/*}/../linux/parse-args.sh

wget -O - https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba

# export MAMBA_ROOT_PREFIX=/some/prefix  # optional, defaults to ~/micromamba

eval "$(./bin/micromamba shell hook -s posix)"

# Linux/bash:
./bin/micromamba shell init -s bash -r ~/micromamba  # this writes to your .bashrc file
# sourcing the bashrc file incorporates the changes into the running session.
# better yet, restart your terminal!
echo "eval \"\$(micromamba shell hook --shell=bash)\" && micromamba activate $ENVIRONMENT_NAME" >> ~/.bashrc
echo 'alias mm=micromamba' >> "${HOME_ABSPATH}/.bash_aliases"

source ~/.bashrc

# micromamba create -n env_name ${environment_name} -c conda-forge
micromamba --version
mm --version

# COPY ${environment_config} /environment.repo.yml
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

#  conda env create --file "/environment.merged.yml"
micromamba env create --file "${home_abspath}/environment.merged.yml" 
