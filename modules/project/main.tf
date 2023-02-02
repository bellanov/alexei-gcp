
resource "google_project" "gcp_project" {
  name       = var.project_name
  project_id = var.project
  org_id     = var.org_id
}