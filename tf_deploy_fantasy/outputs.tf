
output "logs" {
  description = "Logs."
  value       = module.logs
}

output "manifest" {
  description = "Environment Manifest."
  value       = local.manifest
}