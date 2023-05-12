// FantasyAce
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

module "application" {
  source   = "../modules/application"
  for_each = local.environments

  cloud_functions         = each.value.cloud_functions
  cloud_functions_config  = local.cloud_functions_config
  release_bucket          = module.storage.releases

  depends_on = [
    module.storage
  ]
}

locals {
  region   = "us-east1"
  project  = "fantasyace-1682390017"
  zone     = "us-east1-b"
  location = "US"

  cloud_functions_config = {
    "runtime" : "go120",
    "source" : "signals/go",
    "version" : "0.3.3"
  }
  environments = {
    # Development
    "dev" : {
      "cloud_functions" : {
        "AVERAGE" : {},
        "ABOVE_AVERAGE" : {},
        "BALL_DROPPER" : {},
        "BEEN_A_WHILE" : {},
        "BELOW_AVERAGE" : {},
        "COLD_STREAK" : {},
        "HOT_STREAK" : {},
        "PERSONAL_RECORD" : {},
        "SLIPPERY_WHEN_WET" : {},
        "TEMPLATE" : {},
      }
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
