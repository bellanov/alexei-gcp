#!/bin/bash
#
# Create a Service Account in a GCP Project.
PROJECT_ID=$1
SERVICE_ACCOUNT=$2

echo "Service Account: $SERVICE_ACCOUNT"
echo "Creating service accounts & keys: ${SERVICE_ACCOUNT}-${PROJECT_ID}.key"

gcloud iam service-accounts create ${SERVICE_ACCOUNT} --project $PROJECT_ID
