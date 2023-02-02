
resource "google_project" "gcp_project" {
  name       = var.project_name
  project_id = var.project
  org_id     = var.org_id
}

resource "google_project_service" "project_service" {
  count = length(var.apis)
  project = var.project
  service = "${var.apis[count.index]}.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}