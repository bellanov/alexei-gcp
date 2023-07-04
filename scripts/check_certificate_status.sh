#!/bin/bash
#
# Check SSL certificate procurement status.
PROJECT_ID="bellanov-1682390142"
CERTIFICATE_NAME="bellanov-ssl"

gcloud config set project $PROJECT_ID

gcloud compute ssl-certificates describe $CERTIFICATE_NAME \
  --global \
  --format="get(name,managed.status)"

gcloud compute ssl-certificates describe $CERTIFICATE_NAME \
  --global \
  --format="get(managed.domainStatus)"