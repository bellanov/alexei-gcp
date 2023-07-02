
output "name" {
  description = "Website Name."
  value = var.name
}

output "bucket_name" {
  description = "Bucket Name."
  value = google_storage_bucket.static_website.name
}

output "ip_address" {
  description = "IP Address."
  value = var.ip_address
}

output "load_balancer" {
  description = "Load Balancer."
  value = var.load_balancer
}