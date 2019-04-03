#!/usr/bin/env bash

java -Dserver.port=8080 -cp "sample-springboot-app.jar:../dynatrace-pega-aspectj/*" \
-javaagent:../dynatrace-pega-aspectj/aspectjweaver.jar \
-Dorg.aspectj.tracing.debug=true \
org.springframework.boot.loader.JarLauncher