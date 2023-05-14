#!/bin/bash
#
# Create a Service Account in a GCP Project.
PROJECT_ID=$1
SERVICE_ACCOUNT=$2

echo "Executing script: $0"
echo "Creating service account: $SERVICE_ACCOUNT"
gcloud iam service-accounts create ${SERVICE_ACCOUNT} --project $PROJECT_ID
