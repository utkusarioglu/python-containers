#!/bin/bash

set -euxo pipefail
bash --version

echo 'Installing talib'
talib_filename=talib.deb
wget -O $talib_filename https://github.com/ta-lib/ta-lib/releases/download/v0.6.4/ta-lib_0.6.4_amd64.deb
dpkg -i $talib_filename
rm $talib_filename
ta-lib --version
