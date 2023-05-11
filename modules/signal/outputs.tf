
output "archive" {
  description = "Cloud Function Archive (*.zip)."
  value       = google_storage_bucket_object.archive.name
}

output "name" {
  description = "Cloud Function Name."
  value       = google_cloudfunctions_function.function.name
}