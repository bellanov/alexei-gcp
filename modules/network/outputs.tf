
output "dns_managed_zones" {
  description = "DNS Managed Zones."
  value       = { for zone in google_dns_managed_zone.zone : zone.name => zone.id }
}