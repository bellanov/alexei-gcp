#!/bin/bash
#
# Delete a customer environment.
PROJECT_ID='ibhm-1678866092'

echo "Deleting project..."
echo "PROJECT ID: $PROJECT_ID"

gcloud projects delete $PROJECT_ID --quiet
