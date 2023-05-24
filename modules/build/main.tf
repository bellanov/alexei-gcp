
resource "google_cloudbuild_trigger" "build" {
  name            = var.name
  description     = var.description
  filename        = var.filename
  service_account = var.service_account
  project         = var.project

  github {
    name  = var.name
    owner = var.owner

    push {
      invert_regex = false
      tag          = ".*"
    }

  }

}
