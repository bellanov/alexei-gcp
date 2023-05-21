#!/bin/bash
#
# Test the Cloud Run Service Template.
echo 'templatefile("./cloudrun_service.tftpl", { image = "container:v123", service_account = "serviceAccount:service-identity@project.com", env = { PORT = 8080, EDITOR_UPSTREAM_RENDER_URL = "/put/these/configurations/in/data/files" } })' | terraform console
