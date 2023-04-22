#!/bin/bash
#

# Delete customer environment(s) and disable their billing.

for PROJECT in $@
do
    echo "Deleting project: $PROJECT"
    gcloud projects delete $PROJECT --quiet
    gcloud alpha billing projects unlink $PROJECT
done
