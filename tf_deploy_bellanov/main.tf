// Bellanov L.L.C.

# Providers
# 
# Things to simply keep up-to-date...so you don't f*ck yourself over later.
#================================================
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

# Modules
#
# Any possibility of reusing "resource {}" blocks is attempted here.
#================================================

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

# Locals
#
# Area to constrain / harness various configurations to modules / resources. 
#================================================

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
    "location" : "us-central1"
  }

  environments = {
    # Development
    "dev" : {
      "cloud_run_services" : {
        "editor" : {
          "image" : "us-central1-docker.pkg.dev/${local.project}/docker-releases/poc-editor:0.1.1"
        },
        "renderer" : {
          "image" : "us-central1-docker.pkg.dev/${local.project}/docker-releases/poc-renderer:0.1.1"
        }
      }
    },
    # Quality Assurance
    "qa" : {
      "cloud_run_services" : {
        "editor" : {
          "image" : "us-central1-docker.pkg.dev/${local.project}/docker-releases/poc-editor:0.1.1"
        },
        "renderer" : {
          "image" : "us-central1-docker.pkg.dev/${local.project}/docker-releases/poc-renderer:0.1.1"
        }
      }
    },
    # Production
    "prod" : {
      "cloud_run_services" : {
        "editor" : {
          "image" : "us-central1-docker.pkg.dev/${local.project}/docker-releases/poc-editor:0.1.1"
        },
        "renderer" : {
          "image" : "us-central1-docker.pkg.dev/${local.project}/docker-releases/poc-renderer:0.1.1"
        }
      }
    }
  }
}

# Resources
#
# Deploy things that were too annoying to put in a module.
#================================================

// poc-editor
resource "google_cloud_run_service" "editor" {
  for_each = local.environments
  name     = "editor-svc-${each.key}"
  location = local.cloud_run_config.location

  template {
    spec {
      containers {
        image = each.value.cloud_run_services.editor.image

        env {
          name  = "EDITOR_UPSTREAM_RENDER_URL"
          value = each.value.cloud_run_services.editor.image
        }

      }
      service_account_name = module.security.service_accounts["editor-identity"]
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [
    module.security,
    google_cloud_run_service.renderer
  ]
}

// poc-renderer
resource "google_cloud_run_service" "renderer" {
  for_each = local.environments
  name     = "renderer-svc-${each.key}"
  location = local.cloud_run_config.location

  template {
    spec {
      containers {
        image = each.value.cloud_run_services.renderer.image
      }
      service_account_name = module.security.service_accounts["renderer-identity"]
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [
    module.security
  ]
}
