#!/bin/bash

set -eux
bash --version

ARGS=(
  home_abspath
)
. ${0%/*}/../linux/parse-args.sh


# COPY ${environment_config} /environment.repo.yml
RUN yq eval-all \
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

# RUN conda env create --file "/environment.merged.yml"
micromamba env create --file "${home_abspath}/environment.merged.yml" 
