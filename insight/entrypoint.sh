#!/bin/bash
set -e

echo "...Creating bitcore-node.json"
cat <<EOF > /insight/mainnet/bitcore-node.json
{
  "network": "mainnet",
  "port": ${GUIPORT},
  "services": [
    "bitcoind",
    "insight-api-komodo",
    "insight-ui-komodo",
    "web"
  ],
  "servicesConfig": {
    "bitcoind": {
      "connect": [
        {
          "rpchost": "127.0.0.1",
          "rpcport": "${RPCPORT}",
          "rpcuser": "${RPCUSER:-rpcuser}",
          "rpcpassword": "${RPCPASSWORD:-rpcpassword}",
          "zmqpubrawtx": "tcp://127.0.0.1:${ZMQPPORT}"
        }
      ]
    }
  }
}
EOF

exec /insight/mainnet/node_modules/bitcore-node-komodo/bin/bitcore-node start
#/usr/bin/bitcore start
