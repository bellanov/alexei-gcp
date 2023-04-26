#!/bin/bash
#
# Create a GCP Project to house a customer environment.
CUSTOMER_ID=$1
TIMESTAMP="$(date +%s)"
PROJECT_ID="${CUSTOMER_ID}-${TIMESTAMP}"
ORGANIZATION_ID="105637539410"
BILLING_ACCOUNT="0181BD-E8A62D-6B2069"
SERVICE_APIS="Cloud Build API, Cloud Resource Manager, Identity & Access Management, Secret Manager API"
APIS="cloudbuild.googleapis.com cloudresourcemanager.googleapis.com iam.googleapis.com secretmanager.googleapis.com"
SERVICE_ACCOUNTS="cloud-build terraform"

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

ROLES="roles/cloudbuild.builds.editor"
echo "Assigning User Role(s): Cloud Build User"
for ROLE in $ROLES
do
    gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:cloud-build@${PROJECT_ID}.iam.gserviceaccount.com \
    --role=${ROLE}
done


ROLES="roles/storage.admin"
echo "Assigning User Role(s): Terraform User"
for ROLE in $ROLES
do
    gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:terraform@${PROJECT_ID}.iam.gserviceaccount.com \
    --role=${ROLE}
done
