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
  credentials = var.gcp-creds
}

module "storage" {
  source = "./modules/storage"
  project = local.project
}

locals {
  region  = "us-east1"
  project = "development-1-1674398818"
  zone    = "us-east1-b"

  manifest = {
    "dev": {
      "region": "us-east1",
      "zones": ["us-east1-a", "us-east1-b"]
    },
    "staging": {
      "region": "",
      "zones": []
    },
    "ibhm": {
      "region": "",
      "zones": []
    },
    "ibhm_staging": {
      "region": "",
      "zones": []
    }
  }
}
