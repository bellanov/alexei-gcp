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
  source   = "./modules/storage"
  for_each = local.manifest
  project  = local.project
  location = local.location
}

locals {
  # Global Properties
  region   = "us-east1"
  project  = "development-1-1674398818"
  zone     = "us-east1-b"
  location = "US"

  # Properties per Environment
  manifest = {
    "dev" : {},
    "staging" : {},
    "ibhm" : {},
    "ibhm_staging" : {}
  }
}