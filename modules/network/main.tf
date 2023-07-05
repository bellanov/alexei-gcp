
resource "google_dns_managed_zone" "zone" {
  name        = var.name
  dns_name    = var.dns_name
  description = "Organization DNS Zone."
}