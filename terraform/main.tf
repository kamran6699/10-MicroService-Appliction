locals {
  k8s_dir = "${path.module}/../k8s"

  # Apply in a deterministic order (namespace first).
  manifest_files = [
    "${local.k8s_dir}/00-namespace.yaml",
    "${local.k8s_dir}/10-redis.yaml",
    "${local.k8s_dir}/20-services.yaml",
    "${local.k8s_dir}/30-deployments.yaml",
    "${local.k8s_dir}/40-ingress.yaml",
  ]

  # Support multi-document YAML (---) using a simple split.
  manifests = flatten([
    for f in local.manifest_files : [
      for doc in split("\n---\n", trimspace(file(f))) : yamldecode(doc)
    ]
  ])
}

resource "kubernetes_manifest" "resources" {
  for_each = {
    for idx, m in local.manifests :
    "${m.apiVersion}/${m.kind}/${try(m.metadata.namespace, "default")}/${m.metadata.name}/${idx}" => m
  }

  manifest = each.value
}

