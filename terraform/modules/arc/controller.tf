resource "helm_release" "gha_runner_scale_set_controller" {
  name       = "gha-runner-scale-set-controller"
  repository = "oci://ghcr.io/actions/actions-runner-controller-charts"
  chart      = "gha-runner-scale-set-controller"
  namespace  = kubernetes_namespace.arc_systems.metadata[0].name

  values = [
    file("${path.module}/helm/controller_values.yaml")
  ]

  depends_on = [
    kubernetes_secret.github_app_credentials
  ]

  # Run cleanup script before destroying the Helm release
  provisioner "local-exec" {
    when    = destroy
    command = "${path.module}/scripts/cleanup-finalizers.sh ${self.namespace}"
    on_failure = continue
  }
}
