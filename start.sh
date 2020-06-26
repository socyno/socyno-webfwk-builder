#/bin/bash

mkdir -p /opt/h2 && chown -R 1:1 /opt/h2 \
    && mkdir -p /opt/log/tomcat \
    && mkdir -p /opt/log/webfwk \
    && chown -R 1:1 /opt/log \
    && docker run --name webfwk-app -p 8080:8080 -d -v /opt/h2:/opt/h2 \
          -v /opt/log/tomcat:/usr/local/tomcat/logs \
          -v /opt/log/webfwk:/var/log/socyno-webfwk-app \
          -u 1 --rm socyno.org/webfwk \
    && docker run --name webfwk-static -p 80:80 \
          --rm socyno.org/webfwk-static
