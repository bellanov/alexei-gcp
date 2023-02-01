
output "storage" {
  description = "Storage Infrastructure."
  value       = module.storage
}

output "manifest" {
  description = "Environment Manifest."
  value       = local.manifest
}