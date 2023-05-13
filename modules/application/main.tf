
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
