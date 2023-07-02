
resource "google_cloudbuild_trigger" "deployment" {

  name            = var.name
  description     = var.description
  filename        = var.filename
  service_account = var.service_account
  project         = var.project

  github {
    name  = var.repository
    owner = var.owner

    push {
      invert_regex = false
      tag          = ".*"
    }
  }

}