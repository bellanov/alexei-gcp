resource "google_project_service" "project" {
  project = var.project
  service = "${var.service}.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}