#!/bin/bash
#
# Troubleshoot role assignment.
PROJECT_ID=$1


# TERRAFORM_ROLES="roles/cloudbuild.builds.editor"
# echo "Assigning User Role(s): Cloud Build User"
# gcloud projects add-iam-policy-binding ${PROJECT_ID} \
#     --member=serviceAccount:cloud-build@${PROJECT_ID}.iam.gserviceaccount.com \
#     --role=roles/cloudbuild.builds.editor

TERRAFORM_ROLES="roles/storage.admin"
echo "Assigning User Role(s): Terraform User"
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:terraform@${PROJECT_ID}.iam.gserviceaccount.com \
    --role=roles/storage.admin