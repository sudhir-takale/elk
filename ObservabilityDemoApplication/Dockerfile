FROM openjdk:17-jdk-slim

# Install necessary tools
RUN apt-get update && apt-get install -y curl unzip tar procps && apt-get clean

# Set working directory
WORKDIR /app

# Copy application JAR and configs
COPY build/libs/ObservabilityDemoApplication-0.0.1-SNAPSHOT.jar app.jar
COPY src/main/resources/logback-spring.xml /app/logback-spring.xml
COPY src/main/resources/application.properties /app/application.properties
COPY elastic-agent.yml /elastic-agent.yml
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Download Elastic APM agent
RUN curl -L -o /elastic-apm-agent.jar https://repo1.maven.org/maven2/co/elastic/apm/elastic-apm-agent/1.54.0/elastic-apm-agent-1.54.0.jar

# Download and extract Elastic Agent
RUN curl -L -o elastic-agent.tar.gz https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.12.0-linux-x86_64.tar.gz && \
    mkdir /elastic-agent && \
    tar -xzf elastic-agent.tar.gz -C /elastic-agent --strip-components=1 && \
    rm elastic-agent.tar.gz

# Create log directory
RUN mkdir -p /logs /var/log/elastic-agent && chmod -R 755 /logs /var/log/elastic-agent

EXPOSE 8080

CMD ["/start.sh"]
