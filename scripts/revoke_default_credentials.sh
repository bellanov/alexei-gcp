#!/bin/bash
#
# Revoke and disable application default credentials (~/.config/gcloud/application_default_credentials.json).

gcloud auth application-default revoke --quiet
