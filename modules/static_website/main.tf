
resource "random_string" "code" {
  length  = 8
  upper   = false
  special = false
}