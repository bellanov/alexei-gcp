
resource "google_cloudbuild_trigger" "build" {
  name            = "${var.name}-trigger"
  description     = "Cloud Build x GitHub."
  service_account = "projects/${var.project_id}/serviceAccounts/${var.service_account}"

  webhook_config {
    secret = var.github_key
  }

  source_to_build {
    uri       = "https://hashicorp/terraform-provider-google-beta"
    ref       = "refs/heads/main"
    repo_type = "GITHUB"
  }

  git_file_source {
    path      = "cloudbuild.yaml"
    uri       = "https://hashicorp/terraform-provider-google-beta"
    revision  = "refs/heads/main"
    repo_type = "GITHUB"
  }
}