
resource "google_service_account" "build" {
  for_each     = var.builds
  account_id   = "${each.key}-identity"
  display_name = each.value.display_name
}

data "google_iam_policy" "terraform" {
  binding {
    role = "roles/iam.serviceAccountUser"

    members = [
      "serviceAccount:${var.terraform_identity}",
    ]
  }
}

resource "google_service_account_iam_policy" "terraform_iam" {
  for_each           = var.service_accounts
  service_account_id = each.value.service_account
  policy_data        = data.google_iam_policy.terraform.policy_data
}
