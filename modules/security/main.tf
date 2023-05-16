
resource "google_service_account" "account" {
  for_each     = var.service_accounts
  account_id   = "${each.key}-identity"
  display_name = each.value.display_name
}
