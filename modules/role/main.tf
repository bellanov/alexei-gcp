
resource "google_project_iam_member" "cloudbuild" {
  for_each = toset(var.roles)
  role    = each.key
  member  = "serviceAccount:${var.service_account}"
  project = var.project
}