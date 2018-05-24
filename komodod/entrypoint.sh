#!/bin/bash
set -e

echo "...Checking komodo.conf"

if [ ! -e "$HOME/.komodo/komodo.conf" ]; then
    mkdir -p $HOME/.komodo

    echo "...Creating komodo.conf"
    cat <<EOF > $HOME/.komodo/komodo.conf
server=1
whitelist=127.0.0.1
txindex=1
addressindex=1
timestampindex=1
spentindex=1
zmqpubrawtx=tcp://127.0.0.1:8332
zmqpubhashblock=tcp://127.0.0.1:8332
rpcallowip=127.0.0.1
rpcport=8232
rpcuser=${RPCUSER:-rpcuser}
rpcpassword=${RPCPASSWORD:-rpcpassword}
uacomment=bitcore
showmetrics=0
addnode=5.9.102.210
addnode=78.47.196.146
addnode=178.63.69.164
addnode=88.198.65.74
addnode=5.9.122.241
addnode=144.76.94.38
addnode=89.248.166.91
EOF

    cat $HOME/.komodo/komodo.conf
fi

echo "...Checking fetch-params"
$HOME/zcutil/fetch-params.sh
echo "Initialization completed successfully"
echo

echo
echo "****************************************************"
echo "Running: komodod"
echo "****************************************************"

exec komodod
