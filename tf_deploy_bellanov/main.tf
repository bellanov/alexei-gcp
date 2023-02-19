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
  for_each = local.manifest
  project  = each.value.project
  location = local.location
  environment = each.key
}

module "releases" {
  source   = "../modules/releases"
  for_each = local.manifest
  project  = each.value.project
  location = local.location
}

locals {
  region   = "us-east1"
  project = "development-1675315269"
  zone     = "us-east1-b"
  location = "US"

  manifest = {
    "dev" : {
      "project": "development-1675315269",
    },
    "qa" : {
      "project": "development-1675315269",
    },
    "prod" : {
      "project": "development-1675315269",
    }
  }
}
