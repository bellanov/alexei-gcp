
resource "random_string" "code" {
  length  = 8
  upper   = false
  special = false
}

resource "google_project" "gcp_project" {
  name       = var.customer_name
  project_id = "${var.customer}-${random_string.code}"
  org_id     = var.org_id
}