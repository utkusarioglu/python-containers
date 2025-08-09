#!/bin/bash

set -euxo pipefail
bash --version

ARGS=(
  home_abspath
  user_id
  group_id
  environment_name
  python_version
  mamba_root_prefix
)
. /home/dev/scripts/utils/parse-args.sh

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

echo '# Micromamba activate' >> ${home_abspath}/.bashrc
echo "micromamba activate ${environment_name}" >> ${home_abspath}/.bashrc
echo "alias mm=micromamba" >> "${home_abspath}/.bash_aliases"

cat ${home_abspath}/.bashrc
cat ${home_abspath}/.bash_aliases

micromamba --version

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

micromamba create -n ${environment_name}

eval "$(micromamba shell hook -s posix)"
micromamba activate ${environment_name}

micromamba install \
  -n ${environment_name} \
  -c conda-forge \
  python=${python_version} \
  -y 

micromamba install --file "${home_abspath}/environment.merged.yml" -y

which pip

pip install -r ${home_abspath}/requirements.txt --quiet

# This should fix the issue with mm not being able to install anything
# unless as root user
chown -R ${user_id}:${group_id} ${MAMBA_ROOT_PREFIX}

pip list -v

micromamba list
