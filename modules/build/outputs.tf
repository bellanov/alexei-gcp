
output "name" {
  description = "Build Name."
  value       = google_cloudbuild_trigger.build.name
}

output "desc" {
  description = "Build Description."
  value       = google_cloudbuild_trigger.build.id
}

output "id" {
  description = "Build Id."
  value       = google_cloudbuild_trigger.build.id
}
