
output "builds" {
  description = "Cloud Build Triggers."
  value       = { for build in google_cloudbuild_trigger.build : build.name => tomap({ "name" = build.name, "description" = build.description }) }
}
