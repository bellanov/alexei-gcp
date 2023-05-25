// QuantCloud
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
  source              = "../modules/security"
  project             = local.project
  service_accounts    = local.security.service_accounts
  terraform_identity  = local.security.terraform_identity
  cloudbuild_identity = local.security.service_accounts.cloudbuild.email
}

locals {
  region   = "us-east1"
  project  = "quantcloud-1684208465"
  zone     = "us-east1-b"
  location = "US"

  security = {
    "service_accounts" : {
      "cloudbuild" : {
        "display_name" : "Cloud Build User.",
        "service_account" : "projects/${local.project}/serviceAccounts/cloudbuild-identity@${local.project}.iam.gserviceaccount.com",
        "email" : "cloudbuild-identity@${local.project}.iam.gserviceaccount.com"
      }
    },
    "terraform_identity" : "terraform@${local.project}.iam.gserviceaccount.com"
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
