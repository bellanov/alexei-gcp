#!/bin/bash
#
# Create project folder to house a Customer Environment.
PROJECT_ID='bellanov-1677540553'

echo "Deleting project..."
echo "PROJECT ID: $PROJECT_ID"

# Create client environment
gcloud projects delete $PROJECT_ID
