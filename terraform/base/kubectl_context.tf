resource "null_resource" "update_kubeconfig" {
  depends_on = [
    module.eks
  ]

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${local.cluster_name} --region ${local.region} --profile ${local.profile_name}"
  }
}
