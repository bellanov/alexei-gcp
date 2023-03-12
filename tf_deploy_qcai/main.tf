// QuantCloud.AI
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.50.0"
    }
  }
}

provider "google" {
  project     = local.project
  region      = local.region
  zone        = local.zone
  credentials = var.gcp-creds
}

module "storage" {
  source   = "../modules/storage"
  project  = local.project
  location = local.location
}

locals {
  region   = "us-east1"
  project = "development-1675315269"
  zone     = "us-east1-b"
  location = "US"

  releases = {
    "location": local.location
  }

  manifest = {
    "dev" : {},
    "qa" : {},
    "prod" : {}
  }
}
