
output "name" {
  description = "Cloud Function Name."
  value = [ for function in google_cloudfunctions_function.function: function.name]
}
