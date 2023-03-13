#!/bin/bash
#
# Create project folder to house a Customer Environment.
CUSTOMER_ID='bella'
ORGANIZATION_ID='105637539410'
TIMESTAMP=$(date +%s)

echo "Creating project..."
echo "PROJECT ID: $CUSTOMER_ID"

# Create development area
gcloud projects create ${CUSTOMER_ID}-${TIMESTAMP} \
    --organization=${ORGANIZATION_ID} \
    --name=${CUSTOMER_ID}

# TODO: Enable any other necessary APIs here

# Cloud Build Triggers
# Cloud Resource Manager
# Identity & Access Management

# TODO: Create Users (terraform, cloudbuild) and Roles