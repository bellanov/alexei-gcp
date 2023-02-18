
output "log_bucket" {
  description = "Logs Bucket"
  value       = google_storage_bucket.log_bucket.id
}

output "release_bucket" {
  description = "Releases Bucket"
  value       = google_storage_bucket.release_bucket.id
}