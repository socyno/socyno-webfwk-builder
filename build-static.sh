#/bin/bash

cd "$(dirname $0)" && \
    export WORKDIR="$(pwd)" && \
    export WORKSPACE="/opt/workspace" && \
    export BUILDSCRIPT="$WORKSPACE/build-static.sh"
    mkdir -p "$WORKSPACE/socyno-webfwk-static" && \
        cd "$WORKSPACE/socyno-webfwk-static" && \
        git init . && \
        { git remote remove origin; git remote add origin https://github.com/socyno/socyno-webfwk-static.git; } && \
        git fetch origin && \
        git reset --hard FETCH_HEAD && git clean -dfx && git checkout -B master origin/master && \
    echo '#!/bin/sh' > "$BUILDSCRIPT" && \
    echo 'npm config set registry https://registry.npm.taobao.org' >> "$BUILDSCRIPT" && \
    echo 'npm cofig set cache /opt/workspace/npm-cached' >> "$BUILDSCRIPT" && \
    echo 'cd /opt/workspace/socyno-webfwk-static/ || exit $?' >> "$BUILDSCRIPT" && \
    echo 'export NODE_ENV=production || exit $?' >> "$BUILDSCRIPT" && \
    echo 'npm install -g yarn || yarn install --ignore-optional && npm install --dev && npm run build || exit $?' >> "$BUILDSCRIPT" && \
    docker run --rm -it -u root -v "/opt/workspace:/opt/workspace" node:12.18.1-alpine bash "$BUILDSCRIPT"
