
resource "google_cloudbuild_trigger" "build" {
  for_each        = var.builds
  name            = each.key
  description     = each.value.description
  filename        = each.value.filename
  service_account = var.service_account
  project         = var.project

  github {
    name  = each.value.repository
    owner = each.value.owner

    push {
      invert_regex = false
      tag          = ".*"
    }
  }
}
