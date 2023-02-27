#!/bin/bash
#
# Create project folder to house a Customer Environment.
CLIENT_ID='bellanov'
ORGANIZATION_ID='105637539410'
TIMESTAMP=$(date +%s)

echo "Creating project..."
echo "PROJECT ID: $CLIENT_ID"

# Create client environment
gcloud projects create ${CLIENT_ID}-${TIMESTAMP} \
    --organization=${ORGANIZATION_ID} \
    --name=${CLIENT_ID}
