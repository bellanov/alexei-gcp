
output "name" {
  description = "Build Name."
  value       = google_cloudbuild_trigger.build.name
}

output "desc" {
  description = "Build Description."
  value       = google_cloudbuild_trigger.build.description
}

output "id" {
  description = "Build Id."
  value       = google_cloudbuild_trigger.build.id
}
