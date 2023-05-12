#!/bin/bash
#

# Enable Service APIs in a GCP Project.

PROJECT_ID=$1
API=$2

echo "Executing script: $0"
echo "GCP project: $PROJECT_ID"
echo "API: $API"

gcloud services enable $API --project $PROJECT_ID
