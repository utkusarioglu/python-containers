#!/bin/bash

set -euxo pipefail
bash --version

required_packages="gh python nvim git"

for exec in $required_packages;
do
  if [ -z "$(which $exec)" ];
  then
    echo "Error: $exec is not available inside the container"
    exit 1
  fi
done
