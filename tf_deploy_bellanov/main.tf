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

module "cloud_run_services" {
  source   = "../modules/cloud_run_service"
  for_each = local.cloud_run_services

  name = each.key
  env = each.value.env
  image = each.value.image
  location = each.value.location
  service_account = each.value.service_account

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
      "cloudbuild" : {
        "display_name" : "Cloud Build User.",
        "service_account" : "projects/${local.project}/serviceAccounts/cloud-build@${local.project}.iam.gserviceaccount.com"
      },
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

  cloud_run_services = {
    "editor-dev" : {
      "image" : "us-central1-docker.pkg.dev/${local.project}/docker-releases/poc-editor:0.1.1",
      "location" : local.cloud_run_config.location,
      "service_account" : local.cloud_run_config.editor_identity,
      "env" : {
        "EDITOR_UPSTREAM_RENDER_URL" : "/put/these/configurations/in/data/files",
        "PORT" : "8080"
      }
    },
    "editor-qa" : {
      "image" : "us-central1-docker.pkg.dev/${local.project}/docker-releases/poc-editor:0.1.1",
      "location" : local.cloud_run_config.location,
      "service_account" : local.cloud_run_config.editor_identity,
      "env" : {
        "EDITOR_UPSTREAM_RENDER_URL" : "/put/these/configurations/in/data/files",
        "PORT" : "8080"
      }
    },
    "editor-prod" : {
      "image" : "us-central1-docker.pkg.dev/${local.project}/docker-releases/poc-editor:0.1.1",
      "location" : local.cloud_run_config.location,
      "service_account" : local.cloud_run_config.editor_identity,
      "env" : {
        "EDITOR_UPSTREAM_RENDER_URL" : "/put/these/configurations/in/data/files",
        "PORT" : "8080"
      }
    },
    "renderer-dev" : {
      "image" : "us-central1-docker.pkg.dev/${local.project}/docker-releases/poc-renderer:0.1.1",
      "location" : local.cloud_run_config.location,
      "service_account" : local.cloud_run_config.renderer_identity,
      "env" : {
        "PORT" : "8080"
      }
    },"renderer-qa" : {
      "image" : "us-central1-docker.pkg.dev/${local.project}/docker-releases/poc-renderer:0.1.1",
      "location" : local.cloud_run_config.location,
      "service_account" : local.cloud_run_config.renderer_identity,
      "env" : {
        "PORT" : "8080"
      }
    },
    "renderer-prod" : {
      "image" : "us-central1-docker.pkg.dev/${local.project}/docker-releases/poc-renderer:0.1.1",
      "location" : local.cloud_run_config.location,
      "service_account" : local.cloud_run_config.renderer_identity,
      "env" : {
        "PORT" : "8080"
      }
    }
  }

}
