#!/bin/bash
#
# Create project folder to house a Customer Environment.
PROJECT_ID="helldivers"
ORGANIZATION_ID="105637539410"
TIMESTAMP=$(date +%s)
BILLING="014920-61CF35-872C41"

echo "Creating project..."
echo "PROJECT ID: $PROJECT_ID-${TIMESTAMP}"

# Create client environment
gcloud projects create ${PROJECT_ID}-${TIMESTAMP} \
    --organization=${ORGANIZATION_ID} \
    --name=${PROJECT_ID}

# Enable billing in the project (CHASE)
gcloud beta billing projects link ${PROJECT_ID}-${TIMESTAMP} --billing-account ${BILLING}

# Enable project services
gcloud services enable --project ${PROJECT_ID}-${TIMESTAMP} \
    iam.googleapis.com \
    secretmanager.googleapis.com

# Create Terraform service account
gcloud iam service-accounts create terraform --display-name="Terraform User."