#!/bin/bash
#
# Generate application default credentials.

gcloud auth application-default login

# Revoke credentials upon completion
# 
# Configuration Location: ~/.config/gcloud/application_default_credentials.json
# gcloud auth application-default revoke