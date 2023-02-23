
output "bucket" {
  description = "Releases Bucket."
  value       = google_storage_bucket.releases.id
}