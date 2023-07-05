
output "dns_managed_zones" {
  description = "DNS Managed Zones."
  value = google_dns_managed_zone.zone.id
}