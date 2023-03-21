// Bellanov L.L.C.
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

module "builds" {
  source = "../modules/build"
  secret_id = local.github.secret_id
  secret_data = local.github.secret_data
}

locals {

  project = "development-1675315269"
  region   = "us-east1"
  zone     = "us-east1-b"
  location = "US"

  github = {
    "secret_id": "github-build-trigger",
    "secret_data": var.github_creds
  }

  manifest = {
    "dev" : {},
    "qa" : {},
    "prod" : {}
  }

}
  
  
