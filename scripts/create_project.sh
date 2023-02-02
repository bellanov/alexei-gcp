#!/bin/bash
#
# Create project folder to house a Customer Environment.
PROJECT_ID='development'
ORGANIZATION_ID='105637539410'
TIMESTAMP=$(date +%s)

echo "Creating project..."
echo "PROJECT ID: $PROJECT_ID"

gcloud projects create ${PROJECT_ID}-${TIMESTAMP} \
    --organization=${ORGANIZATION_ID} \
    --name=${PROJECT_ID}
