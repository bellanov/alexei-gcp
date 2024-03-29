#!/bin/bash
#
# Create a GCP Project to house a customer environment.
CUSTOMER_ID=$1
TIMESTAMP="$(date +%s)"
PROJECT_ID="${CUSTOMER_ID}-${TIMESTAMP}"
ORGANIZATION_ID="105637539410"
BILLING_ACCOUNT="0181BD-E8A62D-6B2069"
SERVICE_APIS="Artifact Registry, Cloud Build API, Cloud Resource Manager, Identity & Access Management, Secret Manager API"
APIS="artifactregistry.googleapis.com cloudbuild.googleapis.com cloudresourcemanager.googleapis.com iam.googleapis.com secretmanager.googleapis.com"
SERVICE_ACCOUNTS="terraform"

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

echo "Service Accounts: $SERVICE_ACCOUNTS"
for SERVICE_ACCOUNT in $SERVICE_ACCOUNTS
do
    echo "Creating service accounts & keys: ${SERVICE_ACCOUNT}-${PROJECT_ID}.key"
    gcloud iam service-accounts create ${SERVICE_ACCOUNT}
    gcloud iam service-accounts keys create ${SERVICE_ACCOUNT}-${PROJECT_ID}.key \
        --iam-account=${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com
done

ROLES="roles/artifactregistry.admin roles/cloudbuild.builds.editor roles/owner roles/run.admin roles/storage.admin roles/secretmanager.admin roles/iam.serviceAccountAdmin"
echo "Assigning User Role(s): Terraform User"
for ROLE in $ROLES
do
    gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:terraform@${PROJECT_ID}.iam.gserviceaccount.com \
    --role=${ROLE}
done
