# DevOps Runbook (Minikube + Terraform + CI/CD)

This repository contains **Online Boutique** (11 microservices). Application code under `src/` is **unchanged**; only DevOps assets were recreated.

## 1) Local prerequisites

- Docker Desktop
- Minikube (Docker driver)
- kubectl
- Terraform >= 1.5

## 2) Start Minikube (Docker driver)

```bash
minikube start --driver=docker
minikube addons enable ingress
kubectl config use-context minikube
```

## 3) Deploy with Terraform (recommended)

```bash
cd terraform
terraform init
terraform apply -auto-approve
```

## 4) Deploy with kubectl (alternative)

```bash
kubectl apply -f k8s/00-namespace.yaml
kubectl apply -n online-boutique -f k8s/10-redis.yaml
kubectl apply -n online-boutique -f k8s/20-services.yaml
kubectl apply -n online-boutique -f k8s/30-deployments.yaml
kubectl apply -n online-boutique -f k8s/40-ingress.yaml
```

## 5) Build images locally (Minikube-friendly)

If you want to run without pulling from a registry:

```bash
eval $(minikube -p minikube docker-env)
docker build -t frontend:latest src/frontend
docker build -t cartservice:latest src/cartservice/src
docker build -t checkoutservice:latest src/checkoutservice
docker build -t currencyservice:latest src/currencyservice
docker build -t emailservice:latest src/emailservice
docker build -t paymentservice:latest src/paymentservice
docker build -t productcatalogservice:latest src/productcatalogservice
docker build -t recommendationservice:latest src/recommendationservice
docker build -t shippingservice:latest src/shippingservice
docker build -t adservice:latest src/adservice
docker build -t loadgenerator:latest src/loadgenerator
```

## 6) Verify everything

```bash
kubectl -n online-boutique get pods
kubectl -n online-boutique get svc
kubectl -n online-boutique get ingress
```

## 7) Access the frontend (Minikube ingress)

Add a hosts entry:

- `boutique.local` -> `minikube ip`

```bash
minikube ip
```

Then open: `http://boutique.local/`

## 8) CI/CD notes

Workflow file: `.github/workflows/ci-cd.yml`

- Builds and pushes images to GHCR on every push to `main`
- Deploys automatically **only if** you have a **self-hosted Linux runner** labeled `minikube` with access to your Minikube cluster

