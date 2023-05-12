
output "name" {
  description = "Cloud Function Name."
  value       = google_cloudfunctions_function.function.name
}

output "runtime" {
  description = "Cloud Function Runtime."
  value       = google_cloudfunctions_function.function.runtime
}