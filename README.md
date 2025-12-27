# ECS Fargate ML API Deployment

## Overview
This project demonstrates containerization, CI/CD automation, cloud deployment, monitoring, and security best practices using AWS ECS Fargate.

The application exposes two endpoints:
- `GET /health`
- `GET /predict` → `{ "score": 0.75 }`

---

## Architecture Diagram

User
|
| HTTP
v
Application Load Balancer (ALB)
|
| HTTP : 8000
v
ECS Fargate Service
|
v
FastAPI Container


---

## Technology Stack
- Python (FastAPI)
- Docker (multi-stage, non-root)
- AWS ECS Fargate
- Amazon ECR
- Application Load Balancer
- GitHub Actions (CI/CD)
- Amazon CloudWatch (Monitoring & Alerts)

---

## CI/CD Workflow
CI/CD is implemented using GitHub Actions.

On every push to the `main` branch:
1. Docker image is built
2. GitHub Actions authenticates to AWS using OIDC (no static credentials)
3. Image is pushed to Amazon ECR
4. ECS service is updated using a rolling deployment

This ensures zero-downtime deployments.

---

## Deployment Steps
1. Code is pushed to GitHub
2. GitHub Actions builds and pushes image to ECR
3. ECS Fargate pulls the latest image
4. ALB routes traffic to healthy ECS tasks

---

## Monitoring & Alerts

### Metrics
- CPU Utilization (ECS Service)
- Memory Utilization (ECS Service)

### Dashboard
- CloudWatch dashboard with CPU and memory graphs

### Alerts
- High CPU utilization (>70%)
- Unhealthy ECS targets detected by ALB

---

## Security Considerations
- IAM roles follow least-privilege principles
- GitHub Actions uses OIDC (no AWS access keys)
- Containers run as non-root users
- No credentials stored in the repository
- HTTPS can be enforced via ACM with ALB (recommended for production)

---

## Endpoints

### Health Check

Response:
```json
GET /health
{ "status": "ok" }
GET /predict
{ "score": 0.75 }
