
output "storage" {
  description = "Storage Infrastructure."
  value       = module.ibhm_storage
}

output "manifest" {
  description = "Environment Manifest."
  value       = local.manifest
}