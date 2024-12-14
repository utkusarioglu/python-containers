#!/bin/bash

set -eux
bash --version

ARGS=(
  home_abspath
  environment_name
)
. ${0%/*}/../linux/parse-args.sh

micromamba_relpath=bin/micromamba
micromamba_abspath="${home_abspath}/${micromamba_relpath}"

wget -O - https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj "./${micromamba_relpath}"

# export MAMBA_ROOT_PREFIX=/some/prefix  # optional, defaults to ~/micromamba

eval "$(./${micromamba_relpath} shell hook -s posix)"

# Linux/bash:
${micromamba_abspath} shell init -s bash -r ${home_abspath}/micromamba  # this writes to your .bashrc file
# sourcing the bashrc file incorporates the changes into the running session.
# better yet, restart your terminal! echo "eval \"\$(micromamba shell hook --shell=bash)\" && micromamba activate ${environment_name}" >> ${home_abspath}/.bashrc
echo "alias mm=${micromamba_abspath}" >> "${home_abspath}/.bash_aliases"

source ${home_abspath}/.bashrc

# micromamba create -n env_name ${environment_name} -c conda-forge
micromamba --version
# THIS NEEDS TO WORK
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
