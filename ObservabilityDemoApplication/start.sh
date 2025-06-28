
#!/bin/bash
set -e

mkdir -p /app/logs

/elastic-agent/elastic-agent run -c /elastic-agent.yml > /var/log/elastic-agent/elastic-agent.log 2>&1 &

sleep 10

exec java \
  -javaagent:/elastic-apm-agent.jar \
  -Delastic.apm.server_urls=http://65.0.76.204:8200 \
  -Delastic.apm.service_name=spring-app \
  -Delastic.apm.environment=production \
  -Delastic.apm.application_packages=com.example.observability \
  -Delastic.apm.trace_methods_duration_threshold=10ms \
  -Delastic.apm.enable_metrics=true \
  -Delastic.apm.log_level=INFO \
  -jar /app/app.jar
