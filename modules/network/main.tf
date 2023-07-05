
resource "google_dns_managed_zone" "zone" {
  name        = "bellanov"
  dns_name    = "bellanov.com."
  description = "Organization DNS Zone."
}