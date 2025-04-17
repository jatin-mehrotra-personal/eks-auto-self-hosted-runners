# Generate the NodeClass manifest using the template
resource "local_file" "nodeclass_yaml" {
  content = templatefile("${path.module}/templates/nodeclass.yaml.tpl", {
    nodeclass_name    = var.nodeclass_name
    node_role         = aws_iam_role.nodeclass_role.name
    security_group_id = var.cluster_primary_security_group_id
    subnet_id_1a      = var.private_subnets[0]
    subnet_id_1b      = var.private_subnets[1]
    storage_iops      = var.storage_iops
    storage_size      = var.storage_size
    storage_throughput = var.storage_throughput
  })
  filename = "${path.module}/generated/nodeclass.yaml"
}

# Apply the NodeClass manifest using kubectl provider
resource "kubectl_manifest" "nodeclass" {
  yaml_body = local_file.nodeclass_yaml.content
  depends_on = [
    var.eks_dependency,
    local_file.nodeclass_yaml,
    aws_eks_access_policy_association.nodeclass_policy
  ]
}
