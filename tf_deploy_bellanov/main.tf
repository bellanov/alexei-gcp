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

module "build" {
  source   = "../modules/build"
  for_each = local.builds

  description     = each.value.description
  filename        = each.value.filename
  name            = each.key
  owner           = each.value.owner
  project         = local.project
  repository      = each.value.repository
  service_account = local.security.cloudbuild_identity

  depends_on = [
    module.security
  ]
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
      "editor" : {
        "display_name" : "Service identity of the Editor (Frontend) service.",
        "service_account" : "projects/${local.project}/serviceAccounts/editor-identity@${local.project}.iam.gserviceaccount.com"
      },
      "renderer" : {
        "display_name" : "Service identity of the Renderer (Backend) service.",
        "service_account" : "projects/${local.project}/serviceAccounts/renderer-identity@${local.project}.iam.gserviceaccount.com"
      }
    },
    "terraform_identity" : "terraform@${local.project}.iam.gserviceaccount.com",
    "cloudbuild_identity" : "cloud-build@${local.project}.iam.gserviceaccount.com"
  }

  build_config = {
    "owner" : "bellanov",
  }

  cloud_run_config = {
    "location" : "us-central1"
  }

  builds = {
    "cloudrun-poc-editor-2" : {
      "repository" : "cloudrun-poc-editor",
      "filename" : "build.yaml",
      "description" : "Cloud Run Service PoC.",
      "owner" : local.build_config.owner,
      "tag" : ".*"
    },
    "cloudrun-poc-renderer-2" : {
      "repository" : "cloudrun-poc-renderer",
      "filename" : "build.yaml",
      "description" : "Cloud Run Service PoC.",
      "owner" : local.build_config.owner,
      "tag" : ".*"
    },
    "go-template" : {
      "repository" : "go-template",
      "filename" : "build.yaml",
      "description" : "Go development template.",
      "owner" : local.build_config.owner,
      "tag" : ".*"
    },
    "python-template" : {
      "repository" : "python-template"
      "filename" : "build.yaml",
      "description" : "Python development template.",
      "owner" : local.build_config.owner,
      "tag" : ".*"
    },
    "svelte-template" : {
      "repository" : "svelte-template"
      "filename" : "build.yaml",
      "description" : "Svelte development template.",
      "owner" : local.build_config.owner,
      "tag" : ".*"
    }
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

// Data Sources
data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

// poc-editor
//=====================
resource "google_cloud_run_service" "editor" {
  for_each = local.environments
  name     = "editor-ui-${each.key}"
  location = local.cloud_run_config.location

  template {
    spec {
      containers {
        image = each.value.cloud_run_services.editor.image

        env {
          name  = "EDITOR_UPSTREAM_RENDER_URL"
          value = google_cloud_run_service.renderer[each.key].status[0].url
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

resource "google_cloud_run_service_iam_policy" "noauth" {
  for_each = local.environments
  location = google_cloud_run_service.editor[each.key].location
  project  = google_cloud_run_service.editor[each.key].project
  service  = google_cloud_run_service.editor[each.key].name

  policy_data = data.google_iam_policy.noauth.policy_data
}

resource "google_cloud_run_service_iam_member" "editor_invokes_renderer" {
  for_each = local.environments
  location = google_cloud_run_service.renderer[each.key].location
  service  = google_cloud_run_service.renderer[each.key].name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${module.security.service_accounts["editor-identity"]}"

  depends_on = [
    module.security
  ]
}

// poc-renderer
//=====================
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
