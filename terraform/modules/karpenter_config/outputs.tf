output "nodeclass_role_name" {
  description = "Name of the IAM role created for the NodeClass"
  value       = aws_iam_role.nodeclass_role.name
}

output "nodeclass_role_arn" {
  description = "ARN of the IAM role created for the NodeClass"
  value       = aws_iam_role.nodeclass_role.arn
}

output "nodeclass_name" {
  description = "Name of the NodeClass"
  value       = var.nodeclass_name
}

output "nodepool_name" {
  description = "Name of the NodePool"
  value       = var.nodepool_name
}
