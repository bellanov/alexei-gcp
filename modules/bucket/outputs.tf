
output "bucket" {
  description = "Storage Bucket."
  value       = google_storage_bucket.bucket.id
}
