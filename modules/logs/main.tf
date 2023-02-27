
resource "random_string" "code" {
  length  = 8
  upper   = false
  special = false
}

resource "google_storage_bucket" "logs" {
  name          = "${var.environment}-logs-${random_string.code.result}"
  project       = var.project
  location      = var.location
  force_destroy = true

  public_access_prevention = "enforced"
}
