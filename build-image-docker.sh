#/bin/bash

cd "$(dirname $0)" \
    && export WORKDIR="$(pwd)" \
    || exit $?

if [ "$1" != "buildless" ]; then
    bash build-using-docker.sh \ 
        && cp /opt/workspace/webfwk.war "$WORKDIR/docker/" \
        || exit $?
fi

cd "$WORKDIR/docker/" && docker build .
