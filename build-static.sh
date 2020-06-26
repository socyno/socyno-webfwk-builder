#/bin/bash

BUILDLESS=$1

cd "$(dirname $0)" \
   && export WORKDIR="$(pwd)" \
   && export WORKSPACE="/opt/workspace" \
   && export BUILDSCRIPT="$WORKSPACE/build-static.sh" \
   || exit $?

if [ "$BUILDLESS" != "yes" ]; then
    mkdir -p "$WORKSPACE/socyno-webfwk-static" \
        && cd "$WORKSPACE/socyno-webfwk-static" \
        && git init . \
        && { git remote remove origin; git remote add origin https://github.com/socyno/socyno-webfwk-static.git; } \
        && git fetch origin \
        && git reset --hard FETCH_HEAD \
        && git clean -dfx . \
        && git checkout -B master origin/master \
    && echo '#!/bin/sh' > "$BUILDSCRIPT" \
    && echo 'npm config set registry https://registry.npm.taobao.org' >> "$BUILDSCRIPT" \
    && echo "npm config set cache '$WORKSPACE/npm-cached'" >> "$BUILDSCRIPT" \
    && echo "cd '$WORKSPACE/socyno-webfwk-static/' || exit \$?" >> "$BUILDSCRIPT" \
    && echo 'export NODE_ENV=production || exit $?' >> "$BUILDSCRIPT" \
    && echo 'yarn install --ignore-optional && npm install --dev && npm run build || exit $?' >> "$BUILDSCRIPT" \
    && echo "cd dist && tar -cf '$WORKSPACE/webfwk-static.tar' * || exit \$?" >> "$BUILDSCRIPT" \
    && docker run --rm -it -u root -v "$WORKSPACE:$WORKSPACE" node:12.18.1-alpine /bin/sh "$BUILDSCRIPT" \
    || exit $?
fi

cd "$WORKDIR/docker" \
    && cp -f "$WORKSPACE/webfwk-static.tar" . \
    && docker build -t socyno.org/webfwk-static -t socyno.org/webfwk-static:$(date '+%Y-%m-%d_%H-%M')  -f Dockerfile-static .
STATUS=$?
rm -f webfwk-static.tar
exit $STATUS

