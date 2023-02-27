
resource "google_secret_manager_secret" "github_key" {
  secret_id = "github-build-trigger"

  replication {
    user_managed {
      replicas {
        location = "us-central1"
      }
    }
  }
}