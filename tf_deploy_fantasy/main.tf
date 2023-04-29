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
  source      = "../modules/security"
  secret_id   = local.github.secret_id
  secret_data = local.github.secret_data
}

module "build" {
  source   = "../modules/build"
  for_each = local.builds

  github_key      = module.security.github_key
  name            = each.key
  path            = each.value.path
  project_id      = local.project
  revision        = each.value.revision
  service_account = local.service_accounts.terraform
  uri             = each.value.uri

  depends_on = [
    module.security
  ]
}

locals {
  region   = "us-east1"
  project  = "fantasyace-1682390017"
  zone     = "us-east1-b"
  location = "US"

  service_accounts = {
    "terraform" : "terraform"
  }

  github = {
    "secret_id" : "github-credentials",
    "secret_data" : var.github_creds
  }

  builds = {
    "fantasy-signals" : {
      "path" : "build.yaml",
      "uri" : "https://github.com/bellanov/fantasy-signals.git",
      "revision" : "refs/heads/main"
    },
    "fantasy-signals-tests" : {
      "path" : "test.yaml",
      "uri" : "https://github.com/bellanov/fantasy-signals.git",
      "revision" : "refs/heads/main"
    }
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
