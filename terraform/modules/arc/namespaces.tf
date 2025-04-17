resource "kubernetes_namespace" "arc_systems" {
  metadata {
    name = var.arc_systems_namespace
  }

  depends_on = [
    var.eks_cluster_dependency
  ]

  # Run cleanup script before destroying the namespace
  provisioner "local-exec" {
    when       = destroy
    command    = "${path.module}/scripts/cleanup-finalizers.sh ${self.metadata[0].name}"
    on_failure = continue
  }
}

resource "kubernetes_namespace" "arc_runners" {
  metadata {
    name = var.arc_runners_namespace
  }

  depends_on = [
    var.eks_cluster_dependency
  ]

  # Run cleanup script before destroying the namespace
  provisioner "local-exec" {
    when       = destroy
    command    = "${path.module}/scripts/cleanup-finalizers.sh ${self.metadata[0].name}"
    on_failure = continue
  }
}
