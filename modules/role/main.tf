
resource "google_project_iam_member" "cloudbuild" {
  for_each = toset([
    "roles/artifactregistry.writer",
    "roles/cloudbuild.builds.editor",
    "roles/logging.logWriter",
    "roles/storage.admin",
  ])
  role    = each.key
  member  = "serviceAccount:${var.service_account}"
  project = var.project
}