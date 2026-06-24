################################################################################
# General
################################################################################

variable "cluster_name" {
  description = "Name of the EKS cluster to install add-ons on"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# Add-ons
################################################################################

variable "addons" {
  description = <<-EOT
    Map of EKS add-ons to install. Key is the add-on name.
    Example:
    {
      coredns = { version = "v1.11.3-eksbuild.2" }
      vpc-cni = {
        version                  = "v1.18.5-eksbuild.1"
        service_account_role_arn = "arn:aws:iam::123:role/vpc-cni-irsa"
        configuration_values     = jsonencode({ env = { ENABLE_PREFIX_DELEGATION = "true" } })
      }
      kube-proxy = {}
      aws-ebs-csi-driver = { service_account_role_arn = "arn:aws:iam::123:role/ebs-csi-irsa" }
      eks-pod-identity-agent = {}
    }
  EOT
  type = map(object({
    version                     = optional(string)
    resolve_conflicts_on_create = optional(string, "OVERWRITE")
    resolve_conflicts_on_update = optional(string, "OVERWRITE")
    service_account_role_arn    = optional(string)
    configuration_values        = optional(string)
    tags                        = optional(map(string), {})
  }))
  default = {}
}
