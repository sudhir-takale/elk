#!/bin/bash
set -e

# Ensure log directory exists
mkdir -p /logs
chmod 755 /logs

echo "🚀 Starting Elastic Agent..."
/elastic-agent/elastic-agent run -c /elastic-agent.yml &

sleep 10

echo "🚀 Starting Spring Boot app with Elastic APM..."
exec java \
  -javaagent:/elastic-apm-agent.jar \
  -Delastic.apm.service_name=spring-app \
  -Delastic.apm.environment=prod \
  -Delastic.apm.application_packages=com.example \
  -Delastic.apm.server_urls=http://3.109.139.197:8200 \
  -Dlogging.config=/app/logback-spring.xml \
  -Dspring.config.location=/app/application.properties \
  -jar /app/app.jar
