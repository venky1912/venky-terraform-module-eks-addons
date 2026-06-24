# venky-terraform-module-eks-addons

Terraform module for managing EKS core add-ons.

## Features

- Manage any EKS add-on declaratively
- IRSA support per add-on
- Custom configuration values per add-on
- Version pinning with conflict resolution
- Supports all official EKS add-ons (CoreDNS, VPC CNI, kube-proxy, EBS CSI, EFS CSI, Pod Identity Agent, etc.)

## Usage

```hcl
module "eks_addons" {
  source = "git::https://github.com/venky1912/venky-terraform-module-eks-addons.git?ref=v0.1.0"

  cluster_name = module.eks.cluster_name

  addons = {
    coredns                = {}
    vpc-cni                = {
      service_account_role_arn = module.iam.federated_role_arns["vpc-cni"]
      configuration_values = jsonencode({
        env = { ENABLE_PREFIX_DELEGATION = "true" }
      })
    }
    kube-proxy             = {}
    aws-ebs-csi-driver     = { service_account_role_arn = module.iam.federated_role_arns["ebs-csi"] }
    eks-pod-identity-agent = {}
  }

  tags = { Environment = "prod", ManagedBy = "terraform" }
}
```
