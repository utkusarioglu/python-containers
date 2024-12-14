#!/bin/bash

set -eux
bash --version

ARGS=(
  home_abspath
)
. ${0%/*}/../linux/parse-args.sh


RUN pip install -r ${home_abspath}/requirements.txt

RUN pip list -v

RUN micromamba list
