terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.50.0"
    }
  }
}

provider "google" {
  # Configuration options
}

resource "google_storage_bucket" "auto-expire" {
  name          = "no-public-access-bucket"
  location      = "US"
  force_destroy = true

  public_access_prevention = "enforced"
}