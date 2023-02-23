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

module "buckets" {
  source   = "../modules/bucket"
  for_each = local.manifest
  project  = local.project
  location = local.location
  environment = each.key
}

locals {
  region   = "us-east1"
  project = "development-1675315269"
  zone     = "us-east1-b"
  location = "US"

  manifest = {
    "dev" : {
      "buckets": {
        "logs": {},
        "releases": {},
      }
    },
    "qa" : {},
    "prod" : {}
  }
}
