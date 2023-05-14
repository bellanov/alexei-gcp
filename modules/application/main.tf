
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