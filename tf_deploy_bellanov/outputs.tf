
output "buckets" {
  description = "Storage Buckets."
  value       = module.buckets
}

output "manifest" {
  description = "Environment Manifest."
  value       = local.manifest
}

output "releases" {
  description = "Releases."
  value       = module.releases
}