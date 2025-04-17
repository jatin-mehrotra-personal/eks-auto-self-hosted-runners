output "arc_systems_namespace" {
  description = "The namespace where ARC system components are deployed"
  value       = kubernetes_namespace.arc_systems.metadata[0].name
}

output "arc_runners_namespace" {
  description = "The namespace where ARC runners are deployed"
  value       = kubernetes_namespace.arc_runners.metadata[0].name
}

output "github_secret_name" {
  description = "The name of the Kubernetes secret containing GitHub credentials"
  value       = kubernetes_secret.github_app_credentials.metadata[0].name
}

output "controller_name" {
  description = "The name of the deployed ARC controller"
  value       = helm_release.gha_runner_scale_set_controller.name
}

output "runner_set_name" {
  description = "The name of the deployed runner set"
  value       = helm_release.arc_runner_set.name
}

output "dind_runner_set_name" {
  description = "The name of the deployed Docker-in-Docker runner set"
  value       = var.enable_dind_runner ? helm_release.arc_runner_set_dind[0].name : null
}
