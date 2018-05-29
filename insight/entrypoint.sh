#!/bin/bash
set -e

echo "...Creating bitcore-node.json"
cat <<EOF > /insight/livenet/bitcore-node.json
{
  "network": "livenet",
  "port": ${GUIPORT},
  "services": [
    "bitcoind",
    "insight-api",
    "insight-ui",
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

exec /usr/bin/bitcore start
