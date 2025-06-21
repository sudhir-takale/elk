FROM openjdk:17-jdk-slim

# Install required tools
RUN apt-get update && apt-get install -y curl unzip tar

# Set working directory
WORKDIR /app

# Copy your Spring Boot app and config
COPY build/libs/ObservabilityDemoApplication-0.0.1-SNAPSHOT.jar app.jar
COPY logback-spring.xml .
COPY elastic-agent.yml /elastic-agent.yml
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Download Elastic APM Java Agent
RUN curl -L -o /elastic-apm-agent.jar https://repo1.maven.org/maven2/co/elastic/apm/elastic-apm-agent/1.54.0/elastic-apm-agent-1.54.0.jar

# Download and extract Elastic Agent (use version matching your Elasticsearch)
RUN curl -L -o elastic-agent.tar.gz https://artifacts.elastic.co/downloads/beats/elastic-agent/elastic-agent-8.12.0-linux-x86_64.tar.gz && \
    mkdir /elastic-agent && \
    tar -xzf elastic-agent.tar.gz -C /elastic-agent --strip-components=1 && \
    rm elastic-agent.tar.gz

# Create directory for container logs
RUN mkdir -p /var/lib/docker/containers

EXPOSE 8080

# Start both Elastic Agent and Spring Boot app
CMD ["/start.sh"]