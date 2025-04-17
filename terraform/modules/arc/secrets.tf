resource "kubernetes_secret" "github_app_credentials" {
  metadata {
    name      = var.github_secret_name
    namespace = kubernetes_namespace.arc_runners.metadata[0].name
  }

  data = {
    github_app_id              = trimspace(file("${path.module}/secrets/github_app_id.txt"))
    github_app_installation_id = trimspace(file("${path.module}/secrets/github_app_installation_id.txt"))
    github_app_private_key     = trimspace(file("${path.module}/secrets/pem_files/eks-auto-self-hosted-runner.2025-04-02.private-key.pem"))
  }
}
