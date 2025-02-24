#!/usr/bin/env bash

set -euxo pipefail

# clean projects which use the shade plugin to avoid
# Error creating shaded jar: duplicate entry: META-INF/services/co.elastic.apm.agent.shaded.stagemonitor.configuration.ConfigurationOptionProvider
./mvnw -pl apm-agent,apm-agent-attach clean

MOD=$(find apm-agent-plugins -maxdepth 1 -mindepth 1 -type d|grep -v "target"|tr "\n" ",")

./mvnw -q -Dmaven.javadoc.skip=true -am -amd -pl ${MOD} -P integration-test-only verify
