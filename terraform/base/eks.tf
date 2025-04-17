module "eks" {
  source = "../modules/eks"

  cluster_name                   = local.cluster_name
  k8s_version                    = local.k8s_version
  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  node_pools = ["system"]

  enable_cluster_creator_admin_permissions = true

  tags = local.tags
}
