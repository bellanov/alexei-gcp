// Alexei
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.50.0"
    }
  }

  cloud {
    organization = "bellanov"
    workspaces {
      name = "gcp_deploy_alexei"
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
  source             = "../modules/security"
  project            = local.project
  service_accounts   = local.security.service_accounts
  terraform_identity = local.security.terraform_identity
}

module "role" {
  source          = "../modules/role"
  for_each        = local.security.service_accounts
  project         = local.project
  service_account = each.value.email
  roles           = each.value.roles
}

module "build" {
  source          = "../modules/build"
  builds          = local.builds
  project         = local.project
  service_account = local.security.service_accounts.cloudbuild.service_account

  depends_on = [
    module.security
  ]
}

locals {
  region   = "us-east1"
  project  = "alexei-1684209060"
  zone     = "us-east1-b"
  location = "US"

  security = {
    "service_accounts" : {
      "cloudbuild" : {
        "email" : "cloudbuild-identity@${local.project}.iam.gserviceaccount.com"
        "display_name" : "Cloud Build User.",
        "service_account" : "projects/${local.project}/serviceAccounts/cloudbuild-identity@${local.project}.iam.gserviceaccount.com",
        "roles" : [
          "roles/artifactregistry.writer",
          "roles/cloudbuild.builds.editor",
          "roles/logging.logWriter",
          "roles/storage.admin",
        ]
      }
    },
    "terraform_identity" : "terraform@${local.project}.iam.gserviceaccount.com"
  }

  build_config = {
    "owner" : "bellanov",
  }

  cloud_run_config = {
    "location" : "us-central1"
  }

  builds = {}

  environments = {
    # Development
    "dev" : {
      "cloud_run_services" : {},
    },
    # Quality Assurance
    "qa" : {
      "cloud_run_services" : {},
    },
    # Production
    "prod" : {
      "cloud_run_services" : {}
    }
  }
}
