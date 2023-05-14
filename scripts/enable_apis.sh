#!/bin/bash
#

# Enable Service APIs in a GCP Project.

PROJECT_ID=$1
APIS="artifactregistry.googleapis.com cloudbuild.googleapis.com cloudresourcemanager.googleapis.com iam.googleapis.com secretmanager.googleapis.com"

echo "Executing script: $0"
echo "GCP project: $PROJECT_ID"

for API in $APIS
do
    echo "Enabling API: $API"
    gcloud services enable $API --project $PROJECT_ID
done