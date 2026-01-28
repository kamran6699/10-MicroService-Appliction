# Terraform (Minikube)

This Terraform config provisions the Kubernetes resources for the app **into Minikube** using the Kubernetes provider.  
It applies the YAMLs under `../k8s` via `kubernetes_manifest`.

## Prereqs

- Terraform >= 1.5
- `kubectl` configured with a working `minikube` context
- Minikube running (Docker driver)

## Run

```bash
cd terraform
terraform init
terraform apply -auto-approve
```

## Destroy

```bash
cd terraform
terraform destroy -auto-approve
```

