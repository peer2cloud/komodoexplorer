#!/bin/bash
set -e
function createconfig {
    if [[ $# -ne 3 ]]; then
        echo "ERROR: For call functions createconfig use:"
        echo "createconfig homedir coins" 
        exit 1
    fi
    if [[ "$2" = "KMD" ]]; then
        file="komodo.conf"
        path=$1
    else
        path="$1/$2"
        file="$2.conf"
    fi
    echo "...Checking ${path}/${file}"
    ports=($3)
if [ ! -e "${path}/${file}" ]; then
    mkdir -p ${path}
    echo "...Creating ${path}/${file}"
    cat <<EOF > ${path}/${file}
server=1
whitelist=127.0.0.1
txindex=1
addressindex=1
timestampindex=1
spentindex=1
zmqpubrawtx=tcp://127.0.0.1:${ports[1]}
zmqpubhashblock=tcp://127.0.0.1:${ports[1]}
rpcallowip=127.0.0.1
rpcport=${ports[0]}
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
fi
}

source /coinlist
createconfig "/komodo/.komodo" KMD "8232 8332 3001"
for i in "${!coin[@]}"
do
#    str=(${coin[$i]})
    createconfig "/komodo/.komodo" $i "${coin[$i]}"
done

echo "...Checking fetch-params"
$HOME/zcutil/fetch-params.sh
echo "Initialization completed successfully"
echo

echo
echo "****************************************************"
echo "Running: komodod"
echo "****************************************************"
cd /komodo/src
./assetchains
exec komodod 

