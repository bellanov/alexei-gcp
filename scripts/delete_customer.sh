#!/bin/bash
#
# Delete customer environment(s).

for PROJECT in $@
do
    echo "Deleting project: $PROJECT"
    gcloud projects delete $PROJECT --quiet
    gcloud beta billing projects unlink $PROJECT
done
