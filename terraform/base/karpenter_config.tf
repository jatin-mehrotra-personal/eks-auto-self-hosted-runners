module "karpenter_config" {
  source = "../modules/karpenter_config"

  nodeclass_name                    = local.karpenter.nodeclass_name
  nodepool_name                     = local.karpenter.nodepool_name
  cluster_name                      = module.eks.cluster_name
  cluster_primary_security_group_id = module.eks.cluster_primary_security_group_id
  private_subnets                   = module.vpc.private_subnets

  # Storage configuration
  storage_iops       = local.karpenter.storage_iops
  storage_size       = local.karpenter.storage_size
  storage_throughput = local.karpenter.storage_throughput

  # NodePool configuration
  instance_category    = local.karpenter.instance_category
  instance_family      = local.karpenter.instance_family
  instance_cpu         = local.karpenter.instance_cpu
  availability_zones   = local.karpenter.availability_zones
  architecture         = local.karpenter.architecture
  capacity_type        = local.karpenter.capacity_type
  consolidation_policy = local.karpenter.consolidation_policy
  consolidate_after    = local.karpenter.consolidate_after
  cpu_limit            = local.karpenter.cpu_limit

  eks_dependency = module.eks
}
