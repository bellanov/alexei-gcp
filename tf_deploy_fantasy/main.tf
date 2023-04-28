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

module "security" {
  source   = "../modules/security"
  secret_id = local.github.secret_id
  secret_data = local.github.secret_data
}

module "build" {
  source   = "../modules/build"
  project_id = local.project

  depends_on = [
    module.security
  ]
}

locals {
  region   = "us-east1"
  project = "fantasyace-1682390017"
  zone     = "us-east1-b"
  location = "US"

  github = {
    "secret_id": "github-build-trigger",
    "secret_data": var.github_creds
  }

  builds = {
    "fantasy-signals": {}
  }

  environments = {
    # Development
    "dev" : {},
    # Quality Assurance
    "qa" : {},
    # Production
    "prod" : {}
  }
}
