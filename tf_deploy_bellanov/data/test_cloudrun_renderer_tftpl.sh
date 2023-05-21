#!/bin/bash
#
# Test the Cloud Run Service Template.
echo 'templatefile("./cloudrun_service.tftpl", { image = "renderer:v123", service_account = "serviceAccount:service-identity@project.com", env = { PORT = 8080 } })' | terraform console
