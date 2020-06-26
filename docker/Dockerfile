FROM tomcat:7.0.104-jdk8-openjdk

ADD h2.tar /opt/h2tmpl/
ADD start.sh /opt/start.sh
ADD socyno-webfwk.trace.db /opt/h2tmpl/h2/bin/
ADD webfwk.war "/usr/local/tomcat/webapps/"
VOLUME /opt/h2/
CMD [ "bash", "/opt/start.sh" ]
