
resource "google_cloudbuild_trigger" "build" {
  name            = "${var.name}-trigger"
  description     = "Cloud Build x GitHub."
  service_account = "projects/${var.project_id}/serviceAccounts/${var.service_account}"

  webhook_config {
    secret = var.github_key
  }

  source_to_build {
    uri       = var.uri
    ref       = var.revision
    repo_type = "GITHUB"
  }

  git_file_source {
    path      = var.path
    uri       = var.uri
    revision  = var.revision
    repo_type = "GITHUB"
  }
}