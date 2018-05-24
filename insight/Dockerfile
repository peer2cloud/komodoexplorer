FROM ubuntu:16.04

RUN mkdir /insight
ENV HOME /insight

RUN apt-get -y update \
 && apt-get -y install git libzmq3-dev build-essential curl apt-utils \
 && apt-get -y install iputils-ping \
 && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
 && apt-get -y install nodejs \
 && npm install -g --unsafe-perm=true bitcore \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \ 
 && /usr/bin/bitcore create /insight/livenet \
 && cd /insight/livenet \
 && /usr/bin/bitcore install insight-api insight-ui \
 && rm -rf /insight/livenet/node_modules/insight-api \
 && rm -rf /insight/livenet/node_modules/insight-ui \
 && rm -rf /insight/livenet/node_modules/bitcore-lib

# Copy configuration file for Insight
COPY livenet entrypoint.sh /insight/livenet/

WORKDIR /insight/livenet
CMD ["/insight/livenet/entrypoint.sh"]
