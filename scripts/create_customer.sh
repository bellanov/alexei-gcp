#!/bin/bash
#
# Create a project folder to house a customer environment.
CUSTOMER_ID=$1
TIMESTAMP="$(date +%s)"
PROJECT_ID="${CUSTOMER_ID}-${TIMESTAMP}"
ORGANIZATION_ID="105637539410"
BILLING_ACCOUNT="0181BD-E8A62D-6B2069"
SERVICE_APIS="Cloud Build API, Cloud Resource Manager, Identity & Access Management, Secret Manager API"
APIS="cloudbuild.googleapis.com cloudresourcemanager.googleapis.com iam.googleapis.com secretmanager.googleapis.com"
SERVICE_ACCOUNTS="Cloud Build User, Terraform User"

echo "Executing script: $0"
echo "Creating customer environment: $CUSTOMER_ID"

echo "Creating project: $PROJECT_ID"
gcloud projects create ${PROJECT_ID} \
    --organization=${ORGANIZATION_ID} \
    --name=${CUSTOMER_ID}
gcloud config set project $PROJECT_ID

echo "Linking billing account: $BILLING_ACCOUNT"
gcloud beta billing projects link $PROJECT_ID --billing-account $BILLING_ACCOUNT

echo "Service APIs: $SERVICE_APIS"
for API in $APIS
do
    echo "Enabling API: $API"
    gcloud services enable $API
done

echo "Creating service accounts: $SERVICE_ACCOUNTS"
gcloud iam service-accounts create cloud-build
gcloud iam service-accounts create terraform
