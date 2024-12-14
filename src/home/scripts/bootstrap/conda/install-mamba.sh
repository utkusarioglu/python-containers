#!/bin/bash

set -eux
bash --version

wget -O - https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba

# export MAMBA_ROOT_PREFIX=/some/prefix  # optional, defaults to ~/micromamba

eval "$(./bin/micromamba shell hook -s posix)"

# Linux/bash:
./bin/micromamba shell init -s bash -r ~/micromamba  # this writes to your .bashrc file
# sourcing the bashrc file incorporates the changes into the running session.
# better yet, restart your terminal!
# source ~/.bashrc

# micromamba create -n env_name ${environment_name} -c conda-forge

# echo 'alias mm=micromamba' >> "${HOME_ABSPATH}/.bash_aliases"
