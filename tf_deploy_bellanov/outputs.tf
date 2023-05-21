
output "storage" {
  description = "Storage Module."
  value       = module.storage
}

output "application" {
  description = "Application Module."
  value       = module.application
}

output "security" {
  description = "Security Module."
  value       = module.security
}

# Troubleshooting
output "editor_template" {
  description = "Editor (Cloud Run Service) Template."
  value       = local.environments.dev.editor.template
}

output "renderer_template" {
  description = "Renderer (Cloud Run Service) Template."
  value       = local.environments.dev.renderer.template
}