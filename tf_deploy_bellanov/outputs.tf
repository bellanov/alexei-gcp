
output "storage" {
  description = "Storage Infrastructure."
  value       = module.bella_storage
}

output "manifest" {
  description = "Environment Manifest."
  value       = local.manifest
}