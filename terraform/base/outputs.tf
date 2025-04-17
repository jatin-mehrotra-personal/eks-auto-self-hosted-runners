output "kubeconfig_command" {
  description = "Command to update kubeconfig manually if needed"
  value       = "aws eks update-kubeconfig --name ${local.cluster_name} --region ${local.region} --profile ${local.profile_name}"
}

output "runner_scale_set_name" {
  description = "Name of the runner scale set for which will be referenced in workflows for NORMAL JOBS"
  value       = module.arc.runner_set_name
}

output "dind_runner_scale_set_name" {
  description = "Name of the runner scale set for which will be referenced in workflows for DIND (Docker In Docker) JOBS"
  value       = module.arc.dind_runner_set_name
}

