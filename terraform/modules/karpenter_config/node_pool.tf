# Generate the NodePool manifest using the template
resource "local_file" "nodepool_yaml" {
  content = templatefile("${path.module}/templates/nodepool.yaml.tpl", {
    nodepool_name       = var.nodepool_name
    nodeclass_name      = var.nodeclass_name
    instance_category   = var.instance_category
    instance_family     = var.instance_family
    instance_cpu        = var.instance_cpu
    availability_zones  = var.availability_zones
    architecture        = var.architecture
    capacity_type       = var.capacity_type
    consolidation_policy = var.consolidation_policy
    consolidate_after   = var.consolidate_after
    cpu_limit           = var.cpu_limit
  })
  filename = "${path.module}/generated/nodepool.yaml"
}

# Apply the NodePool manifest using kubectl provider
resource "kubectl_manifest" "nodepool" {
  yaml_body = local_file.nodepool_yaml.content
  depends_on = [
    kubectl_manifest.nodeclass,
    local_file.nodepool_yaml
  ]
}
