
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

output "cloud_run_jobs" {
  description = "Cloud Run Jobs."
  value       = { for env in local.environments : env => env.cloud_run_jobs }
}

output "cloud_run_services" {
  description = "Cloud Run Services."
  value       = { for env in local.environments : env => env.cloud_run_services }
}