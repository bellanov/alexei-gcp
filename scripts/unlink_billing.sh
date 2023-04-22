#!/bin/bash
#
# Disable billing in a project. This is useful when projects are shut down yet still have billing enabled.

for PROJECT in $@
do
    echo "Disabling project billing: $PROJECT"
    gcloud alpha billing projects unlink $PROJECT
done
