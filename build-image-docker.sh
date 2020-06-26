#/bin/bash

cd "$(dirname $0)" \
    && export WORKDIR="$(pwd)" \
    || exit $?

if [ "$1" != "buildless" ]; then
    bash build-using-docker.sh \
        || exit $?
fi

cd "$WORKDIR/docker/" \
    && cp /opt/workspace/webfwk.war . \
    && docker build -t socyno.org/webfwk .
STATUS=$?
rm -f webfwk.war
exit $STATUS
