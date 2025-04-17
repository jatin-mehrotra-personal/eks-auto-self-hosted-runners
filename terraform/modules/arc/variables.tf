variable "arc_systems_namespace" {
  description = "Namespace for ARC system components"
  type        = string
}

variable "arc_runners_namespace" {
  description = "Namespace for ARC runners"
  type        = string
}

variable "github_secret_name" {
  description = "Name of the Kubernetes secret for GitHub credentials"
  type        = string
}

variable "min_runners" {
  description = "Minimum number of runners to maintain"
  type        = string
}

variable "enable_dind_runner" {
  description = "Whether to enable Docker-in-Docker runner"
  type        = bool
}

variable "eks_cluster_dependency" {
  description = "Dependency on EKS cluster to ensure it exists before creating ARC resources"
  type        = any
}
