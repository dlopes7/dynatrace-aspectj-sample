#!/usr/bin/env bash

rm *.tmp
rm -rf com

ajc -1.7 -verbose -classpath "dynatrace-pega-aspectj/prhttpcomponents-core-4.1.3.jar:dynatrace-pega-aspectj/oneagent-sdk-1.6.0.jar:dynatrace-pega-aspectj/aspectjrt.jar" \
../src/main/java/com/dynatrace/services/aspects/DynatracePegaAspect.aj -outjar dynatrace-pega-aspectj/dynatrace-pega-aspectj.jar

jar -uf dynatrace-pega-aspectj/dynatrace-pega-aspectj.jar META-INF/aop-ajc.xml




