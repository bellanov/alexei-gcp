
resource "random_string" "code" {
  length  = 8
  upper   = false
  special = false
}

<<<<<<< HEAD:modules/bucket/main.tf
resource "google_storage_bucket" "bucket" {
  name          = "logs-${random_string.code.result}"
=======
resource "google_storage_bucket" "logs" {
  name          = "${var.environment}-logs-${random_string.code.result}"
>>>>>>> fa8e1d71bf4d72038a2e74a6bf64a908569cdaf9:modules/logs/main.tf
  project       = var.project
  location      = var.location
  force_destroy = true

  public_access_prevention = "enforced"
}
