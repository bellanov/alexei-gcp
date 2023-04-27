
output "github_key" {
  description = "GitHub Credentials."
  value = google_secret_manager_secret.github_key.id
}