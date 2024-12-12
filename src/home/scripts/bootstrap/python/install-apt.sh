#!/bin/bash

set -eux

ARGS=(
  additional_apt_packages
)
. ${0%/*}/../linux/parse-args.sh

apt-get install -y \
  ncurses-bin \
  ${additional_apt_packages}
