
resource "google_cloud_run_service" "svc" {
  name     = var.name
  location = var.location
  template {
    spec {
      containers {

        image = var.image

        # env {
        #   name = "each.key"
        #   value = "each.value.value"
        # }
        dynamic "env" {
          for_each = var.env
          content {
            name = each.key
            value = "each.value.value"
          }
        }
      }

      service_account_name = var.service_account
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}