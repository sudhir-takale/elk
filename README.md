
# 📊 Java Application with ELK Stack Observability (Elastic Agent + ECS Fargate)

This repository contains a sample Java application instrumented for observability using the Elastic Stack. It includes:

- Java Application (Spring Boot or similar)
- Dockerfile
- `start.sh` startup script
- `elastic-agent.yml` configuration file

The setup is designed to be deployed in **AWS ECS Fargate** and monitored via **Elasticsearch**, **Kibana**, **APM Server**, and **Heartbeat** hosted on an **EC2 instance**.

---

## 📁 Project Structure

```
├── app/                           # Java Application Source
├── Dockerfile                    # Build Java App + Elastic Agent
├── start.sh                      # Script to start app and Elastic Agent
├── elastic-agent.yml             # Elastic Agent configuration
└── README.md                     # You're here
```

---

## ✅ Requirements

Before deploying, ensure the following components are **installed on your EC2 instance**:

- [x] Elasticsearch 8.18.x  
- [x] Kibana 8.18.x  
- [x] APM Server 8.18.x  
- [x] Heartbeat 8.18.x  
- [x] Open ports: `5601` (Kibana), `9200` (Elasticsearch), `8200` (APM Server)

---

## 🚀 How It Works

- The Java app is containerized with the **Elastic Agent** and the **APM Java Agent**.
- Logs are written to `/app/logs/app.log` and picked up by the Elastic Agent.
- Metrics and logs are sent to Elasticsearch.
- Traces are collected by the APM Java Agent and sent to the APM Server → Elasticsearch.
- Heartbeat running on the EC2 instance pings the app’s health endpoint for uptime monitoring.
- Kibana provides a unified dashboard for logs, traces, and metrics.

---

## 🔧 Setup Instructions

### 🖥️ 1. Install Backend Components on EC2

Install the following services on a Linux-based EC2 instance:
- **Elasticsearch**
- **Kibana**
- **APM Server**
- **Heartbeat**

> Add proper configuration for each, ensuring they listen on public interfaces or private interfaces with allowed security group rules.

📌 _Note: Add your Elasticsearch output and APM server URL in `elastic-agent.yml` accordingly._

---

### 🐳 2. Build Docker Image

From the project root:

```bash
docker build -t my-observable-app .
```

---

### 📦 3. Deploy to ECS Fargate

When defining your **ECS Task Definition**, ensure:

- The container mounts the log volume:
  ```json
  "mountPoints": [
    {
      "sourceVolume": "app-logs",
      "containerPath": "/app/logs"
    }
  ]
  ```
- The log file is created at `/app/logs/app.log` inside the container.

- The container command runs `start.sh`:
  ```json
  "command": [ "./start.sh" ]
  ```

> The `start.sh` script ensures both the Java app and Elastic Agent run simultaneously.

---

### 📄 4. Configure `elastic-agent.yml`

This file contains configuration for:
- Filebeat input to read from `/app/logs/app.log`
- Metrics collection
- Output to Elasticsearch

> ⚠️ Ensure that the hostnames or IPs in `elastic-agent.yml` point to your EC2 instance’s Elasticsearch/APM endpoints.

---

## 🧪 Verification

Once deployed:
- Visit **Kibana** on `http://<EC2-IP>:5601`
- Check:
  - **Logs** in “Logs UI”
  - **Metrics** in “Metrics UI”
  - **Traces** in “APM”
  - **Uptime** in “Uptime UI” from Heartbeat

---

## 📸 Screenshots (Optional)

> You can add screenshots of:
- ECS Task Definition configuration
- Kibana dashboards showing logs/traces
- APM and Uptime views

---

## 📎 Useful Links

- [Elastic Agent Docs](https://www.elastic.co/guide/en/fleet/current/elastic-agent-installation.html)
- [Elastic APM Java Agent](https://www.elastic.co/guide/en/apm/agent/java/current/index.html)
- [ECS Fargate Docs](https://docs.aws.amazon.com/AmazonECS/latest/userguide/what-is-fargate.html)

---

## 👨‍💻 Author

Maintained by Sudhir Takale — for demo or production-grade observability deployments on AWS using Elastic Stack.
