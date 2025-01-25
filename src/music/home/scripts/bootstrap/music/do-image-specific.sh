#!/bin/bash

set -euxo pipefail
bash --version

ARGS=(
  environment_name
)
. /home/dev/scripts/utils/parse-args.sh

mkdir -p /opt/conda/envs/${environment_name}/lib/alsa-lib
ln -s /usr/lib/x86_64-linux-gnu/alsa-lib/libasound_module_conf_pulse.so \
  /opt/conda/envs/${environment_name}/lib/alsa-lib/

mkdir -p /opt/conda/envs/${environment_name}/share/soundfonts
ln -s /usr/share/sounds/sf2/FluidR3_GM.sf2 \
  /opt/conda/envs/${environment_name}/share/soundfonts/default.sf2
