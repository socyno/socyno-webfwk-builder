#/bin/bash

export TOMCATDIR=/usr/local/tomcat/ && \
	export H2BINDIR=/opt/h2/bin && \
	export H2TMPLDIR=/opt/h2tmpl/h2/bin && \
	mkdir -p "$H2BINDIR" && cd "$H2BINDIR" && \
	if [ ! -f 'socyno-webfwk.mv.db' ]; then cp -fr "$H2TMPLDIR"/* ./ ; fi && \
    bash "./h2.sh" && sleep 10 && cd "$TOMCATDIR/bin" && bash ./catalina.sh run
