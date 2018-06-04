FROM ubuntu:16.04

RUN mkdir /insight
ENV HOME /insight

WORKDIR /insight
RUN apt-get -y update \
 && apt-get -y install git libzmq3-dev build-essential curl apt-utils wget \
 && apt-get -y install iputils-ping \
 && apt-get -y install nodejs-legacy npm \
 && wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash \
 && export NVM_DIR="$HOME/.nvm" \
 && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" \
 && nvm install v4 \
 && npm install git+https://git@github.com/peer2cloud/bitcore-node-komodo \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  \
 && npm install http-signature \
 && nvm use v4; /insight/node_modules/bitcore-node-komodo/bin/bitcore-node create mainnet \
 && cd /insight/mainnet && npm install --save fs-extra && npm install --save http-signature har-validator \
 && npm install --save asynckit aws-sign2 aws4 basic-auth caseless  \
    compressible combined-stream forever-agent form-data is-typedarray isstream \
    json-stringify-safe lodash oauth-sign on-headers morgan compression performance-now \
    tough-cookie tunnel-agent \
 && /insight/node_modules/bitcore-node-komodo/bin/bitcore-node install git+https://git@github.com/peer2cloud/insight-api-komodo git+https://git@github.com/peer2cloud/insight-ui-komodo
COPY entrypoint.sh /insight/mainnet/

WORKDIR /insight/mainnet
CMD ["/insight/mainnet/entrypoint.sh"]
