#!/bin/bash

set -e

/elastic-agent/elastic-agent run -c /elastic-agent.yml &

sleep 10

exec java \
  -javaagent:/elastic-apm-agent.jar \
  -Delastic.apm.service_name=spring-app \
  -Delastic.apm.environment=prod \
  -Delastic.apm.application_packages=com.example \
  -Delastic.apm.server_urls=http://3.109.139.197:8200 \
  -jar /app/app.jar