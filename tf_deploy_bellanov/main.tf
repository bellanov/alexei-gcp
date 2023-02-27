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

module "logs" {
  source   = "../modules/logs"
  project  = local.project
  location = local.location
}

module "releases" {
  source   = "../modules/releases"
  project  = local.project
  location = local.releases.location
}

module "builds" {
  source = "../modules/build"
  secret_id = local.github.secret_id
  secret_data = local.github.secret_data
}

locals {
  region   = "us-east1"
  project = "development-1675315269"
  zone     = "us-east1-b"
  location = "US"

  github = {
    "secret_id": "github-build-trigger",
    "secret_data": var.github_creds
  }

  releases = {
    "location": local.location
  }

  manifest = {
    "dev" : {},
    "qa" : {},
    "prod" : {}
  }
}
  
  
