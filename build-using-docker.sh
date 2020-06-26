#/bin/bash

cd "$(dirname $0)" && \
    export WORKDIR="$(pwd)" && \
    docker run --rm -it -u root \
        -v "$(pwd):/opt/build" \
        -v "/opt/workspace:/opt/workspace" \
        codenvy/jdk8_maven3_tomcat8 \
        bash -c "bash /opt/build/build.sh"
