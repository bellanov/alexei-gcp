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
  for_each = local.manifest
  project  = local.project
  location = local.location
}

locals {
  region   = "us-east1"
  customer = "ibhm"
  project = "${local.customer}-1674398818"
  project_name = "Integrated MGMT"
  org_id = "105637539410"
  zone     = "us-east1-b"
  location = "US"
  apis = []

  manifest = {
    "dev" : {},
    "staging" : {},
    "prod" : {}
  }
}
