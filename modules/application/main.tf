
resource "google_cloud_run_service" "svc" {
  for_each = var.cloud_run_services
  name     = each.key
  location = each.value.location
  template = jsonencode(each.value.template)
  traffic {
    percent         = 100
    latest_revision = true
  }
}