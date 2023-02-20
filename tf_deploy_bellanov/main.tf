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
  location = each.value.location
  environment = each.key
}

module "releases" {
  source   = "../modules/releases"
  project  = local.project
  location = local.releases.location
}

locals {
  region   = "us-east1"
  project = "development-1675315269"
  zone     = "us-east1-b"

  releases = {
    "location": "US"
  }

  manifest = {
    "dev" : {
      "project": local.project,
      "location": "US"
    },
    "qa" : {
      "project": local.project,
      "location": "US"
    },
    "prod" : {
      "project": local.project,
      "location": "US"
    }
  }
}
