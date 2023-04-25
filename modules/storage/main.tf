
resource "random_string" "code" {
  length  = 8
  upper   = false
  special = false
}

resource "google_storage_bucket" "logs" {
  name          = "logs-${random_string.code.result}"
  project       = var.project
  location      = "US"
  force_destroy = false

  public_access_prevention = "enforced"
}

resource "google_storage_bucket" "releases" {
  name          = "releases-${random_string.code.result}"
  project       = var.project
  location      = "US"
  force_destroy = false

  public_access_prevention = "enforced"
}