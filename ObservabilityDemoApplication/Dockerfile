FROM openjdk:17-jdk-slim

RUN apt-get update && \
    apt-get install -y curl unzip procps dos2unix && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY build/libs/ObservabilityDemoApplication-0.0.1-SNAPSHOT.jar app.jar

RUN curl -L -o elastic-agent.tar.gz https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.18.2-linux-x86_64.tar.gz && \
    mkdir -p /elastic-agent && \
    tar -xzf elastic-agent.tar.gz -C /elastic-agent --strip-components=1 && \
    rm elastic-agent.tar.gz

RUN curl -L -o /elastic-apm-agent.jar https://search.maven.org/remotecontent?filepath=co/elastic/apm/elastic-apm-agent/1.54.0/elastic-apm-agent-1.54.0.jar

RUN mkdir -p /var/log/elastic-agent && \
    mkdir -p /app/logs && \
    chmod -R 755 /var/log/elastic-agent && \
    chmod -R 755 /app/logs

COPY elastic-agent.yml /elastic-agent.yml
COPY start.sh /start.sh
RUN dos2unix /start.sh && chmod +x /start.sh

EXPOSE 8080

ENTRYPOINT ["/bin/bash", "/start.sh"]
