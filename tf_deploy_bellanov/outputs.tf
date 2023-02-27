
output "logs" {
  description = "Logs."
  value       = module.logs
}

output "manifest" {
  description = "Environment Manifest."
  value       = local.manifest
}

output "releases" {
  description = "Releases."
  value       = module.releases
}

output "builds" {
  description = "Builds."
  value       = module.builds
}