
resource "google_service_account" "renderer" {
  for_each     = var.service_accounts
  account_id   = "renderer-identity"
  display_name = "Service identity of the Renderer (Backend) service."
}
