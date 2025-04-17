variable "nodeclass_name" {
  description = "Name of the NodeClass"
  type        = string
}

variable "nodepool_name" {
  description = "Name of the NodePool"
  type        = string
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_primary_security_group_id" {
  description = "Security group ID for the EKS cluster"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs"
  type        = list(string)
}

# Storage configuration
variable "storage_iops" {
  description = "IOPS for ephemeral storage"
  type        = number
}

variable "storage_size" {
  description = "Size for ephemeral storage"
  type        = string
}

variable "storage_throughput" {
  description = "Throughput for ephemeral storage"
  type        = number
}

# NodePool configuration
variable "instance_category" {
  description = "Instance category for the NodePool"
  type        = list(string)
}

variable "instance_family" {
  description = "Instance family for the NodePool"
  type        = list(string)
}

variable "instance_cpu" {
  description = "Instance CPU for the NodePool"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones for the NodePool"
  type        = list(string)
}

variable "architecture" {
  description = "Architecture for the NodePool"
  type        = list(string)
}

variable "capacity_type" {
  description = "Capacity type for the NodePool"
  type        = list(string)
}

variable "consolidation_policy" {
  description = "Consolidation policy for the NodePool"
  type        = string
}

variable "consolidate_after" {
  description = "Consolidate after duration for the NodePool"
  type        = string
}

variable "cpu_limit" {
  description = "CPU limit for the NodePool"
  type        = string
}

variable "eks_dependency" {
  description = "Dependency on EKS module"
  type        = any
}
