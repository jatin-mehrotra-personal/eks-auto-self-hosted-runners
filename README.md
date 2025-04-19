# EKS Auto-Scaling Self-Hosted GitHub Runners

This repository provides infrastructure as code (IaC) to deploy auto-scaling GitHub Actions self-hosted runners on Amazon EKS using GitHub's Actions Runner Controller (ARC).

## Overview

This solution allows you to:
- Deploy a fully managed EKS cluster with auto-scaling capabilities
- Set up GitHub Actions Runner Controller (ARC) for managing self-hosted runners
- Configure auto-scaling runner sets that scale based on workflow demand
- Support Docker-in-Docker (DinD) runners for container-based workflows

## Architecture

The infrastructure consists of:
- Amazon EKS cluster running in a custom VPC
- GitHub Actions Runner Controller deployed via Helm
- Auto-scaling runner sets configured to scale from 0 to meet demand
- Optional Docker-in-Docker (DinD) runner support
- Karpenter for node auto-scaling (configured but optional)

## Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform v1.0.0+
- kubectl
- Helm v3+
- A GitHub repository or organization where you want to deploy runners
- GitHub App credentials for the Actions Runner Controller

## Setup Instructions

### 1. Configure AWS Profile

Update the `locals.tf` file in the `terraform/base` directory to specify your AWS profile and region:

```hcl
locals {
  region       = "us-east-1"  # Change to your preferred region
  profile_name = "aws-test-admin"  # Change to your AWS profile
}
```

### 2. Configure GitHub App Credentials

1. Create a GitHub App following the [ARC documentation](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners-with-actions-runner-controller/about-actions-runner-controller)
2. Create the following files in the `terraform/modules/arc/secrets` directory:
   - `github_app_id.txt` - Contains your GitHub App ID
   - `github_app_installation_id.txt` - Contains your GitHub App Installation ID
   - `github_app_private_key.pem` - Contains your GitHub App private key
   - `github_config_url.txt` - Contains your GitHub repository or organization URL (e.g., `https://github.com/your-org` or `https://github.com/your-org/your-repo`)

### 3. Deploy the Infrastructure

```bash
cd terraform/base
terraform init
terraform plan
terraform apply
```

### 4. Configure kubectl

After the deployment is complete, configure kubectl to connect to your new EKS cluster:

```bash
aws eks update-kubeconfig --name eks-auto-self-runners --region us-east-1 --profile aws-test-admin
```

### 5. Verify the Deployment

```bash
kubectl get pods -n arc-systems
kubectl get pods -n arc-runners
```

## Using the Self-Hosted Runners

To use the self-hosted runners in your GitHub Actions workflows, specify the runner label in your workflow file:

```yaml
jobs:
  build:
    runs-on: arc-runner-set  # For standard runners
    # OR
    runs-on: arc-runner-set-dind  # For Docker-in-Docker runners
    steps:
      - uses: actions/checkout@v3
      # Your workflow steps here
```

## Customization

### Adjusting Runner Scaling

Modify the `locals.tf` file to adjust the minimum number of runners:

```hcl
locals {
  arc = {
    systems_namespace = "arc-systems"
    runners_namespace = "arc-runners"
    secret_name       = "pre-defined-secret"
    min_runners       = "0"  # Change to desired minimum number of runners
    enable_dind       = true  # Set to false to disable Docker-in-Docker runners
  }
}
```

### Modifying Instance Types

The solution uses Karpenter for node auto-scaling. You can modify the instance types in the `locals.tf` file:

```hcl
locals {
  karpenter = {
    nodeclass_name       = "m7a-spot"
    nodepool_name        = "m7a-spot"
    instance_category    = ["m"]
    instance_family      = ["m7a"]
    instance_cpu         = ["8"]  # Change to desired CPU count
    # Other settings...
  }
}
```

## Cleanup

To destroy the infrastructure and clean up all resources:

```bash
cd terraform/base
terraform destroy
```

The repository includes a cleanup script (`scripts/cleanup-finalizers.sh`) that helps remove Kubernetes finalizers before destroying resources, ensuring a clean teardown.

## Troubleshooting

If you encounter issues with resources not being properly deleted during `terraform destroy`, you can manually run the cleanup script:

```bash
./scripts/cleanup-finalizers.sh arc-systems
./scripts/cleanup-finalizers.sh arc-runners
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.
