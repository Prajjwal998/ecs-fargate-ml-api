# ECS Fargate ML API Deployment

## Objective
This project demonstrates containerization, CI/CD automation, AWS ECS Fargate deployment, monitoring, and security best practices for a simple API service.

The application exposes two endpoints:
- `GET /health`
- `GET /predict` → `{ "score": 0.75 }`

## Architecture

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
- Amazon ECS Fargate
- Amazon ECR
- Application Load Balancer
- GitHub Actions (CI/CD)
- Amazon CloudWatch (Monitoring & Alerts)

---

## Application Endpoints

### Health Check
GET /health
Response:
{ "status": "ok" }

Prediction
GET /predict
Response:
{ "score": 0.75 }

Containerization
  Multi-stage Docker build
  Runs as a non-root user
  Lightweight production image
  Health check enabled
  
CI/CD Pipeline (GitHub Actions)
  CI/CD is implemented using GitHub Actions.
  On every push to the main branch:
    Docker image is built
    GitHub Actions authenticates to AWS using OIDC (no access keys)
    Image is pushed to Amazon ECR
    ECS Fargate service performs a rolling deployment
  This ensures automated and zero-downtime deployments.

Deployment Flow
  Code is pushed to GitHub
  GitHub Actions builds and pushes the image to ECR
  ECS Fargate pulls the latest image
  Application Load Balancer routes traffic to healthy tasks

Monitoring
  Monitoring is implemented using Amazon CloudWatch.

Dashboard
  ECS Service CPU Utilization
  ECS Service Memory Utilization

Alerts
  High CPU utilization (>70%)
  Unhealthy ECS targets detected by ALB

Security Considerations
  IAM roles follow least-privilege access
  GitHub Actions uses OIDC (no static AWS credentials)
  No secrets stored in the repository
  Containers run as non-root users
  HTTPS can be enabled using ACM with ALB (recommended for production)

Status
  ECS Service running on Fargate
  Application Load Balancer healthy
  API publicly accessible
  CI/CD fully automated
  Monitoring and alerts enabled
