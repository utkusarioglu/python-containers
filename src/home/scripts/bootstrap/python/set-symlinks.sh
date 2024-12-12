#!/bin/bash

set -eux

ln -sf $(which python3.13) /usr/bin/python

wget -O - https://bootstrap.pypa.io/get-pip.py | python

pip --version
