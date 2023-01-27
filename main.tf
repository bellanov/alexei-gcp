terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.50.0"
    }
  }
}

provider "google" {
  project     = local.project
  region  = local.region
  zone    = local.zone
  credentials = var.gcp-creds
}


locals {
  region = "us-east1"
  project = "development-1-1674398818"
  zone = "us-east1-b"
}
