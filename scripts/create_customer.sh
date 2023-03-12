#!/bin/bash
#
# Create a project folder to house a customer environment.
CUSTOMER_ID=$1
TIMESTAMP="$(date +%s)"
PROJECT_ID="${CUSTOMER_ID}-${TIMESTAMP}"
ORGANIZATION_ID="105637539410"
BILLING_ACCOUNT="0181BD-E8A62D-6B2069"
ENABLE_APIS="Cloud Build Triggers,Cloud Resource Manager,Identity & Access Management,Secret Manager API"

echo "Executing script: $0"
echo "Creating customer environment: $CUSTOMER_ID"

echo "Creating project: $PROJECT_ID"

gcloud projects create ${PROJECT_ID} \
    --organization=${ORGANIZATION_ID} \
    --name=${CUSTOMER_ID}

echo "Linking billing account: $BILLING_ACCOUNT"

gcloud billing projects link $PROJECT_ID --billing-account $BILLING_ACCOUNT

echo "Enabling APIs: $ENABLE_APIS"
# echo "Service APIs: $CUSTOMER_ID"
# TODO: Enable any other necessary APIs here

# Cloud Build Triggers
# Cloud Resource Manager
# Identity & Access Management
# Secret Manager API

# TODO: Create Users (terraform, cloudbuild) and Roles

# gcloud iam service-accounts create some-account-name --display-name="My Service Account"
