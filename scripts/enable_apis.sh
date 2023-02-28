#!/bin/bash
#
# Enable Service APIs within a GCP Project.
PROJECT_ID='helldivers'

# Enable project services
gcloud services enable --project ${PROJECT_ID} \
    iam.googleapis.com \
    secretmanager.googleapis.com

