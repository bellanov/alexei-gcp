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
  credentials = var.gcp_creds
}

module "storage" {
  source   = "../modules/storage"
  project  = local.project
  location = local.location
}

locals {
  region   = "us-east1"
  project  = "bellanov-1682390142"
  zone     = "us-east1-b"
  location = "US"

  environments = {
    # Development
    "dev" : {
      "cloud_functions" : {}
    },
    # Quality Assurance
    "qa" : {
      "cloud_functions" : {}
    },
    # Production
    "prod" : {
      "cloud_functions" : {}
    }
  }
}
