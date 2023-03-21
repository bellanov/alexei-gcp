#!/bin/bash
#
# Create a project folder to house a customer environment.
CUSTOMER_ID='putr'
ORGANIZATION_ID='105637539410'
TIMESTAMP=$(date +%s)

echo "Creating project..."
echo "PROJECT ID: $CUSTOMER_ID"

gcloud projects create ${CUSTOMER_ID}-${TIMESTAMP} \
    --organization=${ORGANIZATION_ID} \
    --name=${CUSTOMER_ID}

echo "Linking billing account..."
echo "BILLING ACCOUNT: $CUSTOMER_ID"

# gcloud billing projects link my-project --billing-account 0X0X0X-0X0X0X-0X0X0X

echo "Enabling APIs..."
echo "Service APIs: $CUSTOMER_ID"
# TODO: Enable any other necessary APIs here

# Cloud Build Triggers
# Cloud Resource Manager
# Identity & Access Management

# TODO: Create Users (terraform, cloudbuild) and Roles
