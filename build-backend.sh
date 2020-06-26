#/bin/bash

cd "$(dirname $0)" && \
    export WORKDIR="$(pwd)" && \
    export WORKSPACE="/opt/workspace" && \
    export BUILDSCRIPT="$WORKSPACE/build-webfwk-backend.sh" && \
    export MVNSETTINGS="$WORKSPACE/maven-settings.xml" && \
    mkdir -p "$WORKSPACE" && cd "$WORKSPACE" && \
    echo '<?xml version="1.0" encoding="UTF-8"?>' >"$MVNSETTINGS" && \
    echo '<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"' >>"$MVNSETTINGS" && \
    echo '          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' >>"$MVNSETTINGS" && \
    echo '          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">' >>"$MVNSETTINGS" && \
    echo "    <localRepository>${WORKSPACE}/maven-repo/</localRepository>" >>"$MVNSETTINGS" && \
    echo '    <mirrors>' >>"$MVNSETTINGS" && \
    echo '        <mirror>' >>"$MVNSETTINGS" && \
    echo '            <id>nexus-aliyun</id>' >>"$MVNSETTINGS" && \
    echo '            <mirrorOf>central</mirrorOf>' >>"$MVNSETTINGS" && \
    echo '            <name>Nexus aliyun</name>' >>"$MVNSETTINGS" && \
    echo '            <url>http://maven.aliyun.com/nexus/content/groups/public</url>' >>"$MVNSETTINGS" && \
    echo '        </mirror>' >>"$MVNSETTINGS" && \
    echo '    </mirrors>' >>"$MVNSETTINGS" && \
    echo '</settings>' >>"$MVNSETTINGS" && \
    mkdir -p "$WORKSPACE/socyno-jjschema" && cd "$WORKSPACE/socyno-jjschema" && \
        git init . && \
        { git remote remove origin; git remote add origin https://github.com/socyno/socyno-jjschema.git; } && \
        git fetch origin && \
        git reset --hard FETCH_HEAD && git clean -dfx && git checkout -B master origin/master && \
    mkdir -p "$WORKSPACE/socyno-baseutils" && cd "$WORKSPACE/socyno-baseutils" && \
        git init . && \
        { git remote remove origin; git remote add origin https://github.com/socyno/socyno-baseutils.git; } && \
        git fetch origin && \
        git reset --hard FETCH_HEAD && git clean -dfx && git checkout -B master origin/master && \
    mkdir -p "$WORKSPACE/socyno-webutils" && cd "$WORKSPACE/socyno-webutils" && \
        git init . && \
        { git remote remove origin; git remote add origin https://github.com/socyno/socyno-webutils.git; } && \
        git fetch origin && \
        git reset --hard FETCH_HEAD && git clean -dfx && git checkout -B master origin/master && \
    mkdir -p "$WORKSPACE/socyno-statemachine" && cd "$WORKSPACE/socyno-statemachine" && \
        git init . && \
        { git remote remove origin; git remote add origin https://github.com/socyno/socyno-statemachine.git; } && \
        git fetch origin && \
        git reset --hard FETCH_HEAD && git clean -dfx && git checkout -B master origin/master && \
    mkdir -p "$WORKSPACE/socyno-webfwk" && cd "$WORKSPACE/socyno-webfwk" && \
        git init . && \
        { git remote remove origin; git remote add origin https://github.com/socyno/socyno-webfwk.git; } && \
        git fetch origin && \
        git reset --hard FETCH_HEAD && git clean -dfx && git checkout -B master origin/master && \
    mkdir -p "$WORKSPACE/socyno-webfwk-app" && cd "$WORKSPACE/socyno-webfwk-app" && \
        git init . && \
        { git remote remove origin; git remote add origin https://github.com/socyno/socyno-webfwk-app.git; } && \
        git fetch origin && \
        git reset --hard FETCH_HEAD && git clean -dfx && git checkout -B master origin/master && \
    echo '#!/bin/sh' > "$BUILDSCRIPT" && \
    echo "cd '$WORKSPACE/socyno-jjschema' && mvn -s '$MVNSETTINGS' clean install || exit \$?" >> "$BUILDSCRIPT" && \
    echo "cd '$WORKSPACE/socyno-baseutils' && mvn -s '$MVNSETTINGS' clean install || exit \$?" >> "$BUILDSCRIPT" && \
    echo "cd '$WORKSPACE/socyno-webutils' && mvn -s '$MVNSETTINGS' clean install || exit \$?" >> "$BUILDSCRIPT" && \
    echo "cd '$WORKSPACE/socyno-statemachine' && mvn -s '$MVNSETTINGS' clean install || exit \$?" >> "$BUILDSCRIPT" && \
    echo "cd '$WORKSPACE/socyno-webfwk' && mvn -s '$MVNSETTINGS' clean install || exit \$?" >> "$BUILDSCRIPT" && \
    echo "cd '$WORKSPACE/socyno-webfwk-app' && mvn -s '$MVNSETTINGS' clean install || exit \$?" >> "$BUILDSCRIPT" && \
    echo "cp -f target/socyno-webfwk-app-*.war '$WORKSPACE/webfwk.war' || exit \$?" >>"$BUILDSCRIPT" && \
    docker run --rm -it -u root -v "$WORKSPACE:$WORKSPACE" maven:3.6.3-jdk-8 /bin/sh "$BUILDSCRIPT" \
    cd "$WORKDID/docker" && cp "$WORKSPACE/webfwk.war" . && docker build -t socyno.org/webfwk .
STATUS=$?
rm -f webfwk.war
exit $STATUS
