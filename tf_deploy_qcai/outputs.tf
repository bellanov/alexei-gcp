
output "buckets" {
  description = "Storage Buckets."
  value       = module.buckets
}

output "manifest" {
  description = "Environment Manifest."
  value       = local.manifest
}