
resource "google_cloudfunctions_function" "function" {
  for_each    = var.cloud_functions
  name        = each.key
  description = "${each.key}_${each.value.version}"
  runtime     = each.value.runtime
  service_account_email = each.value.service_account

  available_memory_mb   = 128
  source_archive_bucket = var.release_bucket
  source_archive_object = "${each.value.source}/${each.key}_${each.value.version}.zip"
  trigger_http          = true
  entry_point           = each.value.entry_point
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  for_each       = var.cloud_functions
  project        = google_cloudfunctions_function.function[each.key].project
  region         = google_cloudfunctions_function.function[each.key].region
  cloud_function = google_cloudfunctions_function.function[each.key].name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

# resource "google_cloud_run_service" "service" {
#   name     = "public-service"
#   location = "us-central1"

#   template {
#     spec {
#       containers {
#         # TODO<developer>: replace this with a public service container
#         # (This service can be invoked by anyone on the internet)
#         image = "us-docker.pkg.dev/cloudrun/container/hello"

#         # Include a reference to the private Cloud Run
#         # service's URL as an environment variable.
#         env {
#           name  = "URL"
#           value = google_cloud_run_service.private.status[0].url
#         }
#       }

#       # Give the "public" Cloud Run service
#       # a service account's identity
#       service_account_name = google_service_account.default.email
#     }
#   }
# }