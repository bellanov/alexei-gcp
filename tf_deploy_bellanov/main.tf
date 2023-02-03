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

module "apis" {
  source = "../modules/apis"
  count = length(local.services)
  project = local.project
  service = local.services[count.index]
  
}

module "storage" {
  source   = "../modules/storage"
  for_each = local.manifest
  project  = local.project
  location = local.location
}



locals {
  region   = "us-east1"
  project = "development-1675315269"
  zone     = "us-east1-b"
  location = "US"
  services = ["cloudbuild", "cloudresourcemanager"]

  manifest = {
    "dev" : {},
    "staging" : {},
    "prod" : {}
  }
}
