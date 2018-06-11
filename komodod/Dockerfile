FROM ubuntu:16.04

ENV HOME /komodo
WORKDIR /komodo

RUN apt-get -y update \
 && apt-get -y upgrade \
 && apt-get -y install build-essential pkg-config libc6-dev m4 \
        g++-multilib autoconf libtool ncurses-dev unzip python \
        zlib1g-dev wget bsdmainutils automake libssl-dev libprotobuf-dev \
        git protobuf-compiler libqrencode-dev libdb++-dev \
        software-properties-common libcurl4-openssl-dev curl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && git clone -b dev https://github.com/jl777/komodo /komodo \
 && cd /komodo \
 && ./autogen.sh \
 && ./configure --with-incompatible-bdb --with-gui || true \
 && ./zcutil/build.sh -j$(nproc) \
 && ln -sf /komodo/src/komodod /usr/bin/komodod \
 && ln -sf /komodo/zcutil/docker-komodo-cli.sh /usr/bin/komodo-cli

# && apt-get -y remove m4 g++-multilib \
# && apt-get -y autoremove \

COPY ./entrypoint.sh ./coinlist /

CMD ["/entrypoint.sh"]
