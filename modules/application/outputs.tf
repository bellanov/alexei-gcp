
output "cloud_functions" {
  description = "Cloud Functions."
  value = [ for function in google_cloudfunctions_function.function: function.name]
}
