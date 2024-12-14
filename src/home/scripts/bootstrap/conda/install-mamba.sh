#!/bin/bash

set -eux
bash --version

wget -O - https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba
