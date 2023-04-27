
output "logs" {
  description = "Logs Bucket."
  value       = google_storage_bucket.logs.id
}

output "releases" {
  description = "Releases Bucket."
  value       = google_storage_bucket.releases.id
}