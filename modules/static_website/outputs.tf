
output "frontend" {
  description = "Frontend Bucket."
  value       = google_storage_bucket.frontend.id
}

# output "backend" {
#   description = "Backend Bucket."
#   value       = google_storage_bucket.backend.id
# }