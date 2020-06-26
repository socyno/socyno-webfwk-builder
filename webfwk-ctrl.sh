#/bin/bash

ACTION=start
if [ "$1" == "stop" ]; then
    ACTION=stop
fi
if [ "$1" == "restart" ]; then
    ACTION=restart
fi
if [ "$ACTION" != "start" ]; then
    docker rm -f webfwk-static
    STATUS=$?
    docker rm -f webfwk-app
    STATUS=$STATUS || $?
    if [ $STATUS -ne 0 ] || [ "$ACTION" == "stop" ]; then
        exit $STATUS
    fi
fi

docker network create webfwk-network

mkdir -p /opt/h2 && chown -R 1:1 /opt/h2 \
    && mkdir -p /opt/log/tomcat \
    && mkdir -p /opt/log/webfwk \
    && chown -R 1:1 /opt/log \
    && docker run --name webfwk-app -d -v /opt/h2:/opt/h2 \
          -v /opt/log/tomcat:/usr/local/tomcat/logs \
          -v /opt/log/webfwk:/var/log/socyno-webfwk-app \
          --network webfwk-network --network-alias webfwk-app \
          -u 1 --rm socyno.org/webfwk \
    && docker run --name webfwk-static -p 443:443 -d \
          --network webfwk-network --rm socyno.org/webfwk-static
