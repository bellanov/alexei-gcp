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
    "entry_point" : "HelloWorld",
    "runtime" : "go120",
    "source" : "signals/go",
    "service_account" : "terraform@${local.project}.iam.gserviceaccount.com",
  }
  environments = {
    # Development
    "dev" : {
      "cloud_run_services" : {}
    },
    # Quality Assurance
    "qa" : {
      "cloud_run_services" : {}
    },
    # Production
    "prod" : {
      "cloud_run_services" : {}
    }
  }
}
