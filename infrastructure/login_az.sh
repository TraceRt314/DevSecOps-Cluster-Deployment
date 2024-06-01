#!/bin/bash
# This script logs in to Azure using a service principal (use it when Dockerfile is built)
set -o allexport
source .env
set +o allexport

az login --service-principal \
    -u $ARM_CLIENT_ID \
    -p $ARM_CLIENT_SECRET \
    --tenant $ARM_TENANT_ID

