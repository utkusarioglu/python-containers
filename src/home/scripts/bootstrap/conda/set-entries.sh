#!/bin/bash

set -eux
bash --version

ARGS=(
  home_abspath
  environment_name
  mamba_root_prefix
)

echo 'alias mm=micromamba' >> "${HOME_ABSPATH}/.bash_aliases"

# ENV SHELL /bin/bash

# COPY "${SCRIPTS_PATH}" /scripts

# Pushing into `.bashrc` for environment selection
echo "eval \"\$(micromamba shell hook --shell=bash)\" && micromamba activate $ENVIRONMENT_NAME" >> ~/.bashrc
