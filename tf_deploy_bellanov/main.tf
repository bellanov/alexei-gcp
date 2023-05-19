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

module "security" {
  source           = "../modules/security"
  service_accounts = local.security.service_accounts
  terraform_identity = local.security.terraform_identity

}

module "application" {
  source   = "../modules/application"
  for_each = local.environments

  cloud_run_services = each.value.cloud_run_services
  release_bucket = module.storage.releases

  depends_on = [
    module.storage
  ]
}

locals {
  region   = "us-east1"
  project  = "bellanov-1682390142"
  zone     = "us-east1-b"
  location = "US"

  security = {
    "service_accounts" : {
      "renderer" : {
        "display_name" : "Service identity of the Renderer (Backend) service.",
        "service_account": "projects/${local.project}/serviceAccounts/renderer-identity@${local.project}.iam.gserviceaccount.com"
      },
      "editor" : {
        "display_name" : "Service identity of the Editor (Frontend) service.",
        "service_account": "projects/${local.project}/serviceAccounts/editor-identity@${local.project}.iam.gserviceaccount.com"

      }
    },
    "terraform_identity": "terraform@${local.project}.iam.gserviceaccount.com"
  }

  cloud_run_services = {
    location: "us-central1"
  }

  environments = {
    # Development
    "dev" : {
      "cloud_run_services" : {
        "editor": {
          "image": "us-central1-docker.pkg.dev/${local.project}/docker-releases/poc-editor",
          "location": local.cloud_run_services.location,
        },
        "renderer": {
          "image": "us-central1-docker.pkg.dev/${local.project}/docker-releases/poc-renderer",
          "location": local.cloud_run_services.location
        }
      }
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
