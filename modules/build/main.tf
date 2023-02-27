
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

resource "google_secret_manager_secret_version" "github_key_data" {
  secret = google_secret_manager_secret.github_key.id

  secret_data = "secretkeygoeshere"
}