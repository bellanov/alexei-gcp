
resource "google_cloudbuild_trigger" "deployment" {

  name            = var.name
  description     = var.description
  filename        = var.filename
  service_account = var.service_account
  project         = var.project

  github {
    name  = var.repository
    owner = var.owner
  }

  substitutions = {
    _BUILD_ARTIFACT = "bellanov_dev_1.2.3"
    _DEPLOYMENT_BUCKET = "static-website-1234"
    _RELEASES_BUCKET = "releases-4567"
  }
}