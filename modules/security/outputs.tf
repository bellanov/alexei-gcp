

output "service_accounts" {
  description = "Service Accounts."
  value       = [ for account in google_service_account.account : account.account_id ]
}
