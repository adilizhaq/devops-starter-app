# DevOps Starter App

A lightweight Python (Flask) API used to practice end-to-end DevOps workflows.

## Endpoints
- `GET /` — Returns a status message and the current host/container ID
- `GET /health` — Health-check endpoint (`{"status": "ok"}`, HTTP `200`)

## Run with Docker Compose
```bash
docker compose up --build -d
curl http://localhost:5000/health