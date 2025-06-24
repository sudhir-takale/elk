#!/bin/bash
set -e

# Create logs directory
mkdir -p /logs
chmod 755 /logs

# Start Elastic Agent with proper logging
/elastic-agent/elastic-agent run -c /elastic-agent.yml > /var/log/elastic-agent/elastic-agent.log 2>&1 &

# Wait for agent to initialize
sleep 15

# Start Java application with APM
exec java \
  -javaagent:/elastic-apm-agent.jar \
  -Delastic.apm.service_name=spring-app \
  -Delastic.apm.environment=prod \
  -Delastic.apm.application_packages=com.example.observability \
  -Delastic.apm.server_urls=http://3.109.139.197:8200 \
  -Delastic.apm.log_level=DEBUG \
  -Delastic.apm.capture_body=all \
  -Delastic.apm.transaction_sample_rate=1.0 \
  -Delastic.apm.capture_headers=true \
  -Dlogging.config=/app/logback-spring.xml \
  -Dspring.config.location=/app/application.properties \
  -jar /app/app.jar