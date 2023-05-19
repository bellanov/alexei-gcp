
resource "google_cloud_run_service" "svc" {
  for_each = var.cloud_run_services
  name     = each.key
  location = each.value.location
  template {
    spec {
      containers {
        image = each.value.image
      }
      service_account_name = each.value.service_account
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}