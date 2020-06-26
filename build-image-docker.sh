#/bin/bash

cd "$(dirname $0)" && \
    export WORKDIR="$(pwd)" && \
    bash build-using-docker.sh && \
    cp /opt/workspace/webfwk.war "$WORKDIR/docker/" && \
    cd "$WORKDIR/docker/" && \
    docker build .
