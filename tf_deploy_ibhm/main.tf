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

# Prepend the customer / organization as a prefix to modules, as to avoid clashing in Terraform state.
# This allows any customer / organization seamlessly pull in from the same set of root modules.
# If an environment gets too annoying, simply make it its own root module!!!
module "ibhm_storage" {
  source   = "../modules/storage"
  for_each = local.manifest
  project  = local.project
  location = local.location
}

locals {
  region   = "us-east1"
  # Customer environment isolation achieved by GCP project / AWS account
  organization = "ibhm"
  project  = "development-1-1674398818"
  zone     = "us-east1-b"
  location = "US"

  # Properties per Environment
  manifest = {
    "dev" : {},
    "staging" : {},
    "prod" : {}
  }
}
