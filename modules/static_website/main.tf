
resource "random_string" "code" {
  length  = 8
  upper   = false
  special = false
}

resource "google_storage_bucket" "frontend" {
  name          = "frontend-${random_string.code.result}"
  description   = "Static HTML Website - frontend."
  project       = var.project
  location      = "US"
  force_destroy = true

  public_access_prevention = "enforced"

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

# resource "google_compute_backend_bucket" "backend" {
#   name        = "backend-bucket-${random_string.code.result}"
#   description = "Static HTML Website - backend."
#   bucket_name = google_storage_bucket.image_bucket.name
#   enable_cdn  = true
# }

# resource "google_storage_bucket" "backend" {
#   name          = "backend-${random_string.code.result}"
#   project       = var.project
#   location      = "US"
#   force_destroy = false

#   public_access_prevention = "enforced"

#   lifecycle_rule {
#     condition {
#       age = 30
#     }
#     action {
#       type = "Delete"
#     }
#   }

#   lifecycle_rule {
#     condition {
#       age = 1
#     }
#     action {
#       type = "AbortIncompleteMultipartUpload"
#     }
#   }
# }

