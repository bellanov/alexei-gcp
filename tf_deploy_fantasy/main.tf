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

  signals = each.value.signals
  release_bucket = module.storage.releases

  depends_on = [
    module.storage
  ]
}

locals {
  region   = "us-east1"
  project  = "fantasyace-1682390017"
  zone     = "us-east1-b"
  location = "US"

  environments = {
    # Development
    "dev" : {
      "signals" : {
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
      "signals" : {}
    },
    # Production
    "prod" : {
      "signals" : {}
    }
  }
}
