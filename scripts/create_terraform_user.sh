#!/bin/bash
#
# Create a Terraform service account user to deploy infrastructure.
PROJECT_ID="helldivers-12345678"

# Create Terraform service account
gcloud iam service-accounts create terraform --display-name="Terraform User." --project ${PROJECT_ID}
