module "arc" {
  source = "../modules/arc"

  arc_systems_namespace = local.arc.systems_namespace
  arc_runners_namespace = local.arc.runners_namespace
  github_secret_name    = local.arc.secret_name
  min_runners           = local.arc.min_runners
  enable_dind_runner    = local.arc.enable_dind
  
  eks_cluster_dependency = module.eks
}
