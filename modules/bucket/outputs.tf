
output "logs" {
  description = "Logs Bucket."
  value       = google_storage_bucket.logs.id
}
