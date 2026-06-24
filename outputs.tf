output "addon_arns" {
  description = "Map of EKS add-on ARNs"
  value       = { for k, v in aws_eks_addon.this : k => v.arn }
}

output "addon_versions" {
  description = "Map of installed add-on versions"
  value       = { for k, v in aws_eks_addon.this : k => v.addon_version }
}

output "addon_statuses" {
  description = "Map of add-on statuses"
  value       = { for k, v in aws_eks_addon.this : k => v.status }
}
