

output "roles" {
  description = "Role Membership."
  value       = [ for member in google_project_iam_member.cloudbuild : member.role ]
}
