
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
  value = google_compute_global_address.ip_addr.address
}

output "load_balancer" {
  description = "Load Balancer."
  value = var.load_balancer
}