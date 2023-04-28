
resource "google_cloudbuild_trigger" "build" {
  name            = var.name
  description     = "Cloud Build x GitHub."
  service_account = "${var.service_account}@${var.project_id}.iam.gserviceaccount.com"

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