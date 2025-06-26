#!/bin/bash
set -e

mkdir -p /app/logs

/elastic-agent/elastic-agent run -c /elastic-agent.yml > /var/log/elastic-agent/elastic-agent.log 2>&1 &

sleep 5

exec java \
  -javaagent:/elastic-apm-agent.jar \
  -Delastic.apm.service_name=spring-app \
  -Delastic.apm.environment=prod \
  -Delastic.apm.application_packages=com.example.observability \
  -Delastic.apm.server_urls=http://3.109.139.197:8200 \
  -Delastic.apm.log_level=INFO \
  -jar /app/app.jar