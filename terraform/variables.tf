variable "kubeconfig_path" {
  description = "Path to kubeconfig for the target cluster (Minikube)."
  type        = string
  default     = "~/.kube/config"
}

variable "kube_context" {
  description = "Kubeconfig context name."
  type        = string
  default     = "minikube"
}

