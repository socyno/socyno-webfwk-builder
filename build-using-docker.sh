#/bin/bash

cd "$(dirname $0)" && \
    export WORKDIR="$(pwd)" && \
	docker run --rm --it \
	    -v "/opt/workspace:/opt/workspace" \
	    -v "$(pwd):/opt/build" \
	    codenvy/jdk8_maven3_tomcat8 \
	    bash -c "bash /opt/build/build.sh"
