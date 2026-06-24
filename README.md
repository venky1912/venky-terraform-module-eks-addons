<!-- BEGIN_TF_DOCS -->
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

## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0, < 7.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0, < 7.0 |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_eks_addon.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster to install add-ons on | `string` | n/a | yes |
| <a name="input_addons"></a> [addons](#input\_addons) | Map of EKS add-ons to install. Key is the add-on name.<br/>Example:<br/>{<br/>  coredns = { version = "v1.11.3-eksbuild.2" }<br/>  vpc-cni = {<br/>    version                  = "v1.18.5-eksbuild.1"<br/>    service\_account\_role\_arn = "arn:aws:iam::123:role/vpc-cni-irsa"<br/>    configuration\_values     = jsonencode({ env = { ENABLE\_PREFIX\_DELEGATION = "true" } })<br/>  }<br/>  kube-proxy = {}<br/>  aws-ebs-csi-driver = { service\_account\_role\_arn = "arn:aws:iam::123:role/ebs-csi-irsa" }<br/>  eks-pod-identity-agent = {}<br/>} | <pre>map(object({<br/>    version                     = optional(string)<br/>    resolve_conflicts_on_create = optional(string, "OVERWRITE")<br/>    resolve_conflicts_on_update = optional(string, "OVERWRITE")<br/>    service_account_role_arn    = optional(string)<br/>    configuration_values        = optional(string)<br/>    tags                        = optional(map(string), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_addon_arns"></a> [addon\_arns](#output\_addon\_arns) | Map of EKS add-on ARNs |
| <a name="output_addon_statuses"></a> [addon\_statuses](#output\_addon\_statuses) | Map of add-on statuses |
| <a name="output_addon_versions"></a> [addon\_versions](#output\_addon\_versions) | Map of installed add-on versions |
<!-- END_TF_DOCS -->