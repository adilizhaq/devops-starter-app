# DevOps Starter App

A lightweight Python (Flask) API used to practice end-to-end DevOps workflows.

## Endpoints
- `GET /` — Returns a status message and the current host/container ID
- `GET /health` — Health-check endpoint (`{"status": "ok"}`, HTTP `200`)
- `GET /metrics` — Prometheus metrics

## Run locally
```bash
pip install -r requirements-dev.txt
pytest
python app.py
```

## Run with Docker Compose
```bash
docker compose up --build -d
curl http://localhost:5000/health
```

## Monitoring (Prometheus + Grafana)
```bash
cd monitoring
export GRAFANA_ADMIN_PASSWORD='choose-a-password'
docker compose up --build -d
```
Prometheus: http://localhost:9090 · Grafana: http://localhost:3000

## CI/CD
`.github/workflows/ci-cd.yml`:
1. **test** — runs `pytest` on every push and PR to `main`
2. **build-and-push** — on `main`, pushes `ghcr.io/<owner>/devops-starter-app` tagged `latest` and the commit SHA
3. **deploy** — opt-in. Set repository variable `DEPLOY_ENABLED=true` and secret `KUBE_CONFIG` (base64-encoded kubeconfig) to apply `k8s/` and roll out the new SHA

## Kubernetes
```bash
kubectl apply -f k8s/
kubectl port-forward svc/devops-app-service 8080:80
```
The image is pulled from GHCR, so make the package public or add an image pull secret.

## Terraform
```bash
cd terraform
terraform init
terraform apply -var="app_port=5000"
```
Runs the GHCR image in a local Docker container (override with `-var="image=..."`).

## Health check script
```bash
./health_check.sh                      # defaults to http://localhost:5000/health
URL=http://host:port/health ./health_check.sh
```
Exits non-zero when the app is unhealthy, so it works in cron or alerting.
