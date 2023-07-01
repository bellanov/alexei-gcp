
output "name" {
  description = "Website Name."
  value = var.name
}

output "bucket_name" {
  description = "Bucket Name."
  value = google_storage_bucket.static_website.name
}