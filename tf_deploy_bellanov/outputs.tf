
output "storage" {
  description = "Storage Module."
  value       = module.storage
}

output "security" {
  description = "Security Module."
  value       = module.security
}

output "role" {
  description = "Role Module."
  value       = module.role
}

output "network" {
  description = "Network Module."
  value       = module.network
}

output "build" {
  description = "Build Module."
  value       = module.build
}

output "editor" {
  description = "Editor UI."
  value       = { for svc in google_cloud_run_service.editor : svc.name => svc.status[0].url }
}

output "renderer" {
  description = "Renderer Service."
  value       = { for svc in google_cloud_run_service.renderer : svc.name => svc.status[0].url }
}

output "environments" {
  description = "Environments Configuration."
  value       = local.environments
}
