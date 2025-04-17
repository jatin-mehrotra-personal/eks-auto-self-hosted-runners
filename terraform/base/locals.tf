locals {
  region       = "us-east-1"
  profile_name = "aws-test-admin"
}

locals {
  cluster_name = "eks-auto-self-runners"
  k8s_version  = "1.31"
}

locals {
  node_group_desired_size = 2
}

locals {
  tags = {
    Environment = "github-self-hosted-runners-eks-auto"
  }
}

locals {
  vpc = {
    name                   = "eks-auto-mode"
    cidr                   = "10.0.0.0/16"
    azs                    = ["us-east-1a", "us-east-1b"]
    private_subnets        = ["10.0.1.0/24", "10.0.2.0/24"]
    public_subnets         = ["10.0.4.0/24", "10.0.5.0/24"]
    enable_nat_gateway     = true
    single_nat_gateway     = true
    one_nat_gateway_per_az = false
    enable_dns_hostnames   = true
    enable_dns_support     = true
    public_subnet_tags = {
      "kubernetes.io/role/elb" = "1"
    }
    private_subnet_tags = {
      "kubernetes.io/role/internal-elb" = "1"
    }
  }
}

locals {
  arc = {
    systems_namespace = "arc-systems"
    runners_namespace = "arc-runners"
    secret_name       = "pre-defined-secret"
    min_runners       = "0"
    enable_dind       = true
  }
}

locals {
  karpenter = {
    nodeclass_name       = "m7a-spot"
    nodepool_name        = "m7a-spot"
    storage_iops         = 5000
    storage_size         = "300Gi"
    storage_throughput   = 500
    instance_category    = ["m"]
    instance_family      = ["m7a"]
    instance_cpu         = ["8"]
    availability_zones   = ["us-east-1a", "us-east-1b"]
    architecture         = ["amd64"]
    capacity_type        = ["spot"]
    consolidation_policy = "WhenEmpty"
    consolidate_after    = "5m"
    cpu_limit            = "1000"
  }
}

