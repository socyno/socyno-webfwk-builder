#/bin/bash

export TOMCATDIR=/home/user/tomcat8 && \
	export H2BINDIR=/opt/h2/bin && \
	export H2TMPLDIR=/opt/h2tmpl/bin && \
    cd "$H2BINDIR" && if [ ! -d 'socyno-webfwk.trace.db' ]; then cp -fr "$H2TMPLDIR"/* "$H2BINDIR/"; fi && \
    bash "./h2.sh" && sleep 10 && cd "$TOMCATDIR/bin" && bash ./catalina.sh run
