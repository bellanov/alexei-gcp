#!/bin/bash
#
# Set the roles for a GCP Project.
PROJECT_ID=$1

echo "Executing script: $0"
echo "Refreshing project roles: $PROJECT_ID"

EXISTING_ROLES="roles/cloudbuild.builds.editor roles/secretmanager.admin roles/secretmanager.secretAccessor roles/storage.admin"

echo "Removing Existing Role(s): Terraform User"
for ROLE in $EXISTING_ROLES
do
    gcloud projects remove-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:terraform@${PROJECT_ID}.iam.gserviceaccount.com \
    --role=${ROLE}
done

ASSIGN_ROLES="roles/cloudbuild.builds.editor roles/secretmanager.admin roles/secretmanager.secretAccessor roles/storage.admin"

echo "Assigning User Role(s): Terraform User"
for ROLE in $ASSIGN_ROLES
do
    gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:terraform@${PROJECT_ID}.iam.gserviceaccount.com \
    --role=${ROLE}
done
