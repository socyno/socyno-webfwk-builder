#/bin/bash

export WORKSPACE=/opt/workspace && \
	export H2BINDIR=/opt/h2/bin && \
	export H2TMPLDIR=/opt/h2tmpl/bin && \
    export MVNSETTINGS="$WORKSPACE/maven-settigs.xml" && \
    rm -fr "$WORKSPACE" && mkdir -p "$WORKSPACE" && cd "$WORKSPACE" && \
    echo '<?xml version="1.0" encoding="UTF-8"?>' >"$MVNSETTINGS" && \
    echo '<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"' >>"$MVNSETTINGS" && \
    echo '          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' >>"$MVNSETTINGS" && \
    echo '          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">' >>"$MVNSETTINGS" && \
    echo "    <localRepository>${WORKSPACE}</localRepository>" >>"$MVNSETTINGS" && \
    echo '    <mirrors>' >>"$MVNSETTINGS" && \
    echo '        <mirror>' >>"$MVNSETTINGS" && \
    echo '            <id>nexus-aliyun</id>' >>"$MVNSETTINGS" && \
    echo '            <mirrorOf>central</mirrorOf>' >>"$MVNSETTINGS" && \
    echo '            <name>Nexus aliyun</name>' >>"$MVNSETTINGS" && \
    echo '            <url>http://maven.aliyun.com/nexus/content/groups/public</url>' >>"$MVNSETTINGS" && \
    echo '        </mirror>' >>"$MVNSETTINGS" && \
    echo '    </mirrors>' >>"$MVNSETTINGS" && \
    echo '</settings>' >>"$MVNSETTINGS" && \
    git clone https://github.com/socyno/socyno-jjschema.git && \
    git clone https://github.com/socyno/socyno-baseutils.git && \
    git clone https://github.com/socyno/socyno-webutils.git && \
    git clone https://github.com/socyno/socyno-statemachine.git && \
    git clone https://github.com/socyno/socyno-webfwk.git && \
    git clone https://github.com/socyno/socyno-webfwk-app.git && \
    cd "$WORKSPACE/socyno-jjschema" && mvn -s "$MVNSETTINGS" clean install && \
    cd "$WORKSPACE/socyno-baseutils" && mvn -s "$MVNSETTINGS" clean install && \
    cd "$WORKSPACE/socyno-webutils" && mvn -s "$MVNSETTINGS" clean install && \
    cd "$WORKSPACE/socyno-statemachine" && mvn -s "$MVNSETTINGS" clean install && \
    cd "$WORKSPACE/socyno-webfwk" && mvn -s "$MVNSETTINGS" clean install && \
    cd "$WORKSPACE/socyno-webfwk-app" && mvn -s "$MVNSETTINGS" clean install && \
    cd "$H2BINDIR" && if [ ! -d 'socyno-webfwk.trace.db' ]; then cp -fr "$H2TMPLDIR"/* "$H2BINDIR/"; fi && \
    bash "./h2.sh" && sleep 10 && \
    cp -f "$WORKSPACE/socyno-webfwk-app/targat/*.war" /home/user/tomcat8/webapps/webfwk.war && \
    cd /home/user/tomcat8/bin && bash ./catalina.sh run
