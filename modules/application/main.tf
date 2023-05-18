
resource "google_cloud_run_service" "svc" {
  for_each = var.cloud_run_services
  name     = "renderer"
  location = "us-central1"
  template {
    spec {
      containers {
        # Replace with the URL of your Secure Services > Renderer image.
        #   gcr.io/<PROJECT_ID>/renderer
        image = "us-central1-docker.pkg.dev/fantasyace-1682390017/docker-releases/poc-renderer"
      }
      service_account_name = "ayoayo@topdog.com"
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}