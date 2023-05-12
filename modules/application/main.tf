
resource "google_storage_bucket_object" "archive" {
  for_each = var.cloud_functions
  name   = "${each.key}_${var.cloud_functions_version}.zip"
  bucket = var.release_bucket
  source = "./path/to/zip/file/which/contains/code"
}

resource "google_cloudfunctions_function" "function" {
  for_each = var.cloud_functions
  name        = each.key
  description = "${each.key}_${var.cloud_functions_version} Cloud Function"
  runtime     = "nodejs16"

  available_memory_mb   = 128
  source_archive_bucket = var.release_bucket
  source_archive_object = google_storage_bucket_object.archive[each.key].name
  trigger_http          = true
  entry_point           = "helloGET"
}

