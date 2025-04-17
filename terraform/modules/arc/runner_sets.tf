resource "helm_release" "arc_runner_set" {
  name       = "arc-runner-set"
  repository = "oci://ghcr.io/actions/actions-runner-controller-charts"
  chart      = "gha-runner-scale-set"
  namespace  = kubernetes_namespace.arc_runners.metadata[0].name

  values = [
    file("${path.module}/helm/arc_listener_values.yaml")
  ]

  set {
    name  = "githubConfigUrl"
    value = trimspace(file("${path.module}/secrets/github_config_url.txt"))
  }

  set {
    name  = "githubConfigSecret"
    value = kubernetes_secret.github_app_credentials.metadata[0].name
  }

  set {
    name  = "minRunners"
    value = var.min_runners
  }

  depends_on = [
    helm_release.gha_runner_scale_set_controller
  ]

  # Run cleanup script before destroying the Helm release
  provisioner "local-exec" {
    when    = destroy
    command = "${path.module}/scripts/cleanup-finalizers.sh ${self.namespace}"
    on_failure = continue
  }
}

resource "helm_release" "arc_runner_set_dind" {
  count      = var.enable_dind_runner ? 1 : 0
  name       = "arc-runner-set-dind"
  repository = "oci://ghcr.io/actions/actions-runner-controller-charts"
  chart      = "gha-runner-scale-set"
  namespace  = kubernetes_namespace.arc_runners.metadata[0].name

  values = [
    file("${path.module}/helm/arc_listener_values_dind.yaml")
  ]

  set {
    name  = "githubConfigUrl"
    value = trimspace(file("${path.module}/secrets/github_config_url.txt"))
  }

  set {
    name  = "githubConfigSecret"
    value = kubernetes_secret.github_app_credentials.metadata[0].name
  }

  set {
    name  = "minRunners"
    value = var.min_runners
  }

  depends_on = [
    helm_release.gha_runner_scale_set_controller
  ]

  # Run cleanup script before destroying the Helm release
  provisioner "local-exec" {
    when    = destroy
    command = "${path.module}/scripts/cleanup-finalizers.sh ${self.namespace}"
    on_failure = continue
  }
}
