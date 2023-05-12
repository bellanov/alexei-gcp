
output "name" {
  description = "Cloud Function Name."
  value = [ for function in google_cloudfunctions_function.function: function.name]
}

output "runtime" {
  description = "Cloud Function Runtime."
  value = [ for function in google_cloudfunctions_function.function: function.runtime]
}