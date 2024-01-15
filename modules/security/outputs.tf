

output "service_accounts" {
  description = "Service Accounts."
  value       = { for sa in google_service_account.sa : sa.account_id => tomap({ "id" = sa.id, "email" = sa.email }) }
}
