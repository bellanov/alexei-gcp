#!/bin/bash
#
# Delete a customer environment.
PROJECT_ID='fantasy-1678866290'

echo "Deleting project..."
echo "PROJECT ID: $PROJECT_ID"

gcloud projects delete $PROJECT_ID --quiet
