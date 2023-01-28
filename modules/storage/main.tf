
resource "random_string" "code" {
  length           = 4
  special          = false
}

resource "google_storage_bucket" "log_bucket" {
  name          = "logs-${random_string.code.result}"
  location      = "US"
  force_destroy = true

  public_access_prevention = "enforced"
}

resource "google_storage_bucket" "release_bucket" {
  name          = "releases-${random_string.code.result}"
  location      = "US"
  force_destroy = true

  public_access_prevention = "enforced"
}