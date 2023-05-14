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

  cloud_functions         = each.value.cloud_functions
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
      "cloud_functions" : {
        "AVERAGE" : {
          "entry_point" : local.cloud_functions_config.entry_point,
          "runtime" : local.cloud_functions_config.runtime,
          "service_account" : local.cloud_functions_config.service_account,
          "source" : local.cloud_functions_config.source,
          "version" : "0.3.2"
        },
        "ABOVE_AVERAGE" : {
          "entry_point" : local.cloud_functions_config.entry_point,
          "runtime" : local.cloud_functions_config.runtime,
          "service_account" : local.cloud_functions_config.service_account,
          "source" : local.cloud_functions_config.source,
          "version" : "0.3.2"
        },
        "BALL_DROPPER" : {
          "entry_point" : local.cloud_functions_config.entry_point,
          "runtime" : local.cloud_functions_config.runtime,
          "service_account" : local.cloud_functions_config.service_account,
          "source" : local.cloud_functions_config.source,
          "version" : "0.3.2"
        },
        "BEEN_A_WHILE" : {
          "entry_point" : local.cloud_functions_config.entry_point,
          "runtime" : local.cloud_functions_config.runtime,
          "service_account" : local.cloud_functions_config.service_account,
          "source" : local.cloud_functions_config.source,
          "version" : "0.3.2"
        },
        "BELOW_AVERAGE" : {
          "entry_point" : local.cloud_functions_config.entry_point,
          "runtime" : local.cloud_functions_config.runtime,
          "service_account" : local.cloud_functions_config.service_account,
          "source" : local.cloud_functions_config.source,
          "version" : "0.3.2"
        },
        "COLD_STREAK" : {
          "entry_point" : local.cloud_functions_config.entry_point,
          "runtime" : local.cloud_functions_config.runtime,
          "service_account" : local.cloud_functions_config.service_account,
          "source" : local.cloud_functions_config.source,
          "version" : "0.3.2"
        },
        "HOT_STREAK" : {
          "entry_point" : local.cloud_functions_config.entry_point,
          "runtime" : local.cloud_functions_config.runtime,
          "service_account" : local.cloud_functions_config.service_account,
          "source" : local.cloud_functions_config.source,
          "version" : "0.3.2"
        },
        "PERSONAL_RECORD" : {
          "entry_point" : local.cloud_functions_config.entry_point,
          "runtime" : local.cloud_functions_config.runtime,
          "service_account" : local.cloud_functions_config.service_account,
          "source" : local.cloud_functions_config.source,
          "version" : "0.3.2"
        },
        "SLIPPERY_WHEN_WET" : {
          "entry_point" : local.cloud_functions_config.entry_point,
          "runtime" : local.cloud_functions_config.runtime,
          "service_account" : local.cloud_functions_config.service_account,
          "source" : local.cloud_functions_config.source,
          "version" : "0.3.2"
        },
        "TEMPLATE" : {
          "entry_point" : local.cloud_functions_config.entry_point,
          "runtime" : local.cloud_functions_config.runtime,
          "service_account" : local.cloud_functions_config.service_account,
          "source" : local.cloud_functions_config.source,
          "version" : "0.3.2"
        },
      }
    },
    # Quality Assurance
    "qa" : {
      "cloud_functions" : {}
    },
    # Production
    "prod" : {
      "cloud_functions" : {}
    }
  }
}
