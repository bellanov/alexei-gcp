
resource "google_dns_managed_zone" "zone" {
  for_each    = var.dns_managed_zones
  name        = each.key
  dns_name    = each.value.dns_name
  description = "Organization DNS Zone."
}