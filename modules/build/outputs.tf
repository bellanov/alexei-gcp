
output "secret_id" {
  description = "Build Credentials."
  value = google_secret_manager_secret.github_key.id
}