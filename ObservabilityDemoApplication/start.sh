#!/bin/bash
set -e

mkdir -p /app/logs

/elastic-agent/elastic-agent run -c /elastic-agent.yml > /var/log/elastic-agent/elastic-agent.log 2>&1 &

sleep 10

exec java -jar /app/app.jar
