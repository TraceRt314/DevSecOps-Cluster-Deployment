#!/bin/bash

az aks get-credentials --resource-group $RESOURCE_GROUP_NAME --name $CLUSTER_NAME
ansible-playbook --extra-vars project_name=$PROJECT_NAME rbac/execute-namespace-procedures.yml
