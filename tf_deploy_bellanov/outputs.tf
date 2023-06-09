
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

output "editor_ui" {
  description = "Editor UI."
  value       = { for svc in google_cloud_run_service.editor : svc.id => svc.status }
}

output "renderer_svc" {
  description = "Renderer Service."
  value       = { for svc in google_cloud_run_service.renderer : svc.id => svc.status }
}
