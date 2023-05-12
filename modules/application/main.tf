
resource "google_storage_bucket_object" "archive" {
  for_each = var.cloud_functions
  name     = "${each.key}_${var.cloud_functions_version}.zip"
  bucket   = var.release_bucket
  source   = var.cloud_functions_source
}

resource "google_cloudfunctions_function" "function" {
  for_each    = var.cloud_functions
  name        = each.key
  description = "${each.key}_${var.cloud_functions_version}"
  runtime     = "nodejs16"

  available_memory_mb   = 128
  source_archive_bucket = var.release_bucket
  source_archive_object = google_storage_bucket_object.archive[each.key].name
  trigger_http          = true
  entry_point           = "helloGET"
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  for_each       = var.cloud_functions
  project        = google_cloudfunctions_function.function[each.key].project
  region         = google_cloudfunctions_function.function[each.key].region
  cloud_function = google_cloudfunctions_function.function[each.key].name

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}
