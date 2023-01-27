#!/bin/bash
#
# Create project folder to house environment (Dev, QA, Prod).
PROJECT_ID='development-1'
ORGANIZATION_ID='105637539410'
TIMESTAMP=$(date +%s)

echo "Creating project..."
echo "PROJECT ID: $PROJECT_ID"

gcloud projects create ${PROJECT_ID}-${TIMESTAMP} \
    --organization=${ORGANIZATION_ID} \
    --name=${PROJECT_ID}
