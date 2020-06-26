#/bin/bash

cd "$(dirname $0)" && \
    export WORKDIR=$(pwd) && \
    bash build.sh && \
    cd "$WORKDIR" && \
    cp webfwk.war docker/ && \
    cd docker/ && \
    docker build .
