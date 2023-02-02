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

module "project" {
  source = "../modules/project"
  customer = local.customer
  customer_name = local.customer_name  
  org_id = local.org_id
}

module "storage" {
  source   = "../modules/storage"
  for_each = local.manifest
  project  = local.project
  location = local.location
}

locals {
  region   = "us-east1"
  customer = "bella"
  customer_name = "Bellanov LLC"
  org_id = "105637539410"
  zone     = "us-east1-b"
  location = "US"

  manifest = {
    "dev" : {},
    "staging" : {},
    "prod" : {}
  }
}
