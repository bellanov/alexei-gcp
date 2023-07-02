
output "name" {
  description = "deployment Name."
  value       = google_cloudbuild_trigger.deployment.name
}

output "desc" {
  description = "deployment Description."
  value       = google_cloudbuild_trigger.deployment.description
}

output "id" {
  description = "deployment Id."
  value       = google_cloudbuild_trigger.deployment.id
}
