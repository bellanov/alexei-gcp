
// Unique identifier for resources
resource "random_string" "code" {
  length  = 8
  upper   = false
  special = false
}

// Store HTML website contents
resource "google_storage_bucket" "static_website" {
  name          = "static-website-${random_string.code.result}"
  location      = "US"
  storage_class = "STANDARD"
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

// Grant PUBLIC access to the bucket
resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.static_website.id
  role   = "READER"
  entity = "allUsers"
}

// Reserve IP Address
resource "google_compute_global_address" "ip_addr" {
  name     = "static-website-${random_string.code.result}-ip"
}
