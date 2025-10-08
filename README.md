# Full-Stack FastAPI + React - MOnitoring & Cloud Deployment

**Project:** Full-Stack FastAPI + React template (Dockerized)
**Purpose:** Demo + portfolio project - shows containerization, monitoring, logging, reverse proxying, and cloud deployment.
---

## About

This repository contains a full-stack sample application built with:

- **Frontend:** React (+ ChakraUI)
- **Backend:** FastAPI (Python)
- **Database:** PostgreSQL (Adminer for DB UI)
- **Reverse Proxy:** Nginx
- **Monitoring / Logging:** Prometheus, Grafana, Loki, Promtail, cAdvisor
- **Containerization / Orchestration:** Docker + Docker Compose
- **Deployed to:** `ayobamiagboola.duckdns.org` on AWS

**Repository:** `[https://github.com/iamay0bami/cv-challenge01-fastapi-react]`  
**Live demo:** `https://ayobamiagboola.duckdns.org` 
---

## Quick start (local / server)

1. Clone:
```bash
git clone https://github.com/iamay0bami/cv-challenge01-fastapi-react
cd cv-challenge01-fastapi-react

2. Start all services (application + monitoring):
docker compose -f docker-compose.yml -f docker-compose.monitoring.yml up -d --build

3. Verify services:
docker ps
# frontend -> http://localhost/ (or http://<host>/)
# backend -> http://localhost/api
# grafana -> http://localhost/grafana
---

**Architecture**
Frontend (React) served at /, Reverse Proxy routes /api and /docs to FastAPI, and proxies /grafana & /prometheus to the monitoring stack. Promtail forwards container logs to Loki. Prometheus scrapes metrics from backend and cAdvisor.
---

Services & Routes
| Service     | Path          | Notes              |
| ----------- | ------------- | ------------------ |
| Frontend    | `/`           | React app          |
| Backend API | `/api`        | FastAPI app        |
| API docs    | `/docs`       | FastAPI Swagger UI |
| Grafana     | `/grafana`    | Dashboards & Logs  |
| Prometheus  | `/prometheus` | Metrics UI         |
| Adminer     | `/adminer`    | DB browser         |
