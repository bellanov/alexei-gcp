
resource "google_service_account" "renderer" {
  account_id   = "renderer-identity"
  display_name = "Service identity of the Renderer (Backend) service."
}
