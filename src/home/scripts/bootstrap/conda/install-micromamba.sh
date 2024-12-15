#!/bin/bash

set -eux
bash --version

ARGS=(
  home_abspath
  user_id
  group_id
  environment_name
  mamba_root_prefix
)
. ${0%/*}/../linux/parse-args.sh

export MAMBA_ROOT_PREFIX=$mamba_root_prefix

mkdir -p ${MAMBA_ROOT_PREFIX}
chown -R ${user_id}:${group_id} ${MAMBA_ROOT_PREFIX}

wget -O - https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba

mv bin/micromamba /usr/bin/micromamba

micromamba shell init -s bash

bashrc_temp=${home_abspath}/.bashrc-temp
echo '# Micromamba shell eval' >> /root/.bashrc
cat /root/.bashrc >> ${bashrc_temp}
cat ${home_abspath}/.bashrc >> ${bashrc_temp}
mv ${bashrc_temp} ${home_abspath}/.bashrc

# eval '$(micromamba shell hook -s posix)' >> ${home_abspath}/.bashrc
echo '# Micromamba activate' >> ${home_abspath}/.bashrc
echo "micromamba activate ${environment_name}" >> ${home_abspath}/.bashrc
echo "alias mm=micromamba" >> "${home_abspath}/.bash_aliases"

cat ${home_abspath}/.bashrc
cat ${home_abspath}/.bash_aliases

# source ${home_abspath}/.bashrc
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

# source ${home_abspath}/.bashrc

eval "$(micromamba shell hook -s posix)"
micromamba activate ${environment_name}

which pip

pip install -r ${home_abspath}/requirements.txt

pip list -v

micromamba list
