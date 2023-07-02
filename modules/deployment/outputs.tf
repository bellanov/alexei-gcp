
output "name" {
  description = "deployment Name."
  value       = google_clouddeployment_trigger.deployment.name
}

output "desc" {
  description = "deployment Description."
  value       = google_clouddeployment_trigger.deployment.description
}

output "id" {
  description = "deployment Id."
  value       = google_clouddeployment_trigger.deployment.id
}
