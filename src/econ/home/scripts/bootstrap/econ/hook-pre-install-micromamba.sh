#!/bin/bash

set -euxo pipefail
bash --version

TALIB_VERSION=0.8.3
# 0.6.4
echo 'Installing talib'
talib_filename=talib.deb
wget -O $talib_filename "https://github.com/ta-lib/ta-lib/releases/download/v${TALIB_VERSION}/ta-lib_${TALIB_VERSION}_amd64.deb"
dpkg -i $talib_filename
rm $talib_filename
# echo 'See if ta-lib has been installed here:'
# dpkg -l | grep talib
# echo "--"
