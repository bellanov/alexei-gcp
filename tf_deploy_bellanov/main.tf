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
  source             = "../modules/security"
  service_accounts   = local.security.service_accounts
  terraform_identity = local.security.terraform_identity
}



resource "google_cloud_run_service" "editor_svc" {
  for_each = local.environments
  name     = each.value.name
  location = each.value.location
  template {
    spec {
      containers {

        image = each.value.image

        env {
          name  = "PORT"
          value = "8080"
        }

        env {
          name  = "EDITOR_UPSTREAM_RENDER_URL"
          value = "/why/not/just/do/this/to/begin/with"
        }

      }

      service_account_name = var.service_account
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}
resource "google_cloud_run_service" "renderer_svc" {
  for_each = local.environments
  name     = var.name
  location = var.location
  template {
    spec {
      containers {

        image = "${each.key}:v1.2.3"

        env {
          name  = "PORT"
          value = "8080"
        }

      }

      service_account_name = var.service_account
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
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
        "service_account" : "projects/${local.project}/serviceAccounts/renderer-identity@${local.project}.iam.gserviceaccount.com"
      },
      "editor" : {
        "display_name" : "Service identity of the Editor (Frontend) service.",
        "service_account" : "projects/${local.project}/serviceAccounts/editor-identity@${local.project}.iam.gserviceaccount.com"
      }
    },
    "terraform_identity" : "terraform@${local.project}.iam.gserviceaccount.com"
  }

  cloud_run_config = {
    "editor_identity" : "editor-identity@${local.project}.iam.gserviceaccount.com",
    "location" : "us-central1",
    "renderer_identity" : "renderer-identity@${local.project}.iam.gserviceaccount.com"
  }

  environments = {
    # Development
    "dev" : {
      "cloud_run_services" : {
        "editor" : {
          "image" : "us-central1-docker.pkg.dev/${local.project}/docker-releases/poc-editor:0.1.1",
          "location" : local.cloud_run_config.location,
          "service_account" : local.cloud_run_config.editor_identity
        },
        "renderer" : {
          "image" : "us-central1-docker.pkg.dev/${local.project}/docker-releases/poc-renderer:0.1.1",
          "location" : local.cloud_run_config.location,
          "service_account" : local.cloud_run_config.renderer_identity
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
