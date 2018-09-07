#!/bin/bash
set -e
echo "****************************************************"
echo "Rebuild: komodod"
echo "****************************************************"
cd /komodo
git pull --rebase
make clean
./zcutil/build.sh -j$(nproc)
