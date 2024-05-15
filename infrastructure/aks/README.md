# AKS Deployment

- [AKS Deployment](#aks-deployment)
  - [Architecture](#architecture)
  - [Getting started](#getting-started)
    - [1 - Docker Installation](#1---docker-installation)
    - [2 - Retrieve Azure Credentials](#2---retrieve-azure-credentials)
    - [3 - Build the infrastructure provisioner docker image](#3---build-the-infrastructure-provisioner-docker-image)
      - [4 - Ensure exec permissions over `entrypoint.sh`](#4---ensure-exec-permissions-over-entrypointsh)
      - [5 - Run docker container for provision](#5---run-docker-container-for-provision)
  - [Expected Outputs](#expected-outputs)


This folder contains the `IaC Terraform definition for setting AKS` with just a single CLI utility.

## Architecture

TODO: Include arch diagram


## Getting started

### 1 - Docker Installation

Make sure to have Docker CE installed in your local machine. For further reference, check [Docker Install Official Documentation](https://docs.docker.com/engine/install)

### 2 - Retrieve Azure Credentials

> \[!IMPORTANT\]
> This playbook is intended for administrators. Therefore, you will need to have the `Owner` role for executing the playbook. For more granular permissions set-up, check Azure documentation.

1. Login with Azure CLI:

```bash
az login --use-device-code
```

### 3 - Build the infrastructure provisioner docker image

```bash
docker build ../docker -f ../docker/Dockerfile.provisioner -t cluster-provider:1.0 \
--build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg USER=$(id -un) --build-arg GROUP=$(id -gn)
```

#### 4 - Ensure exec permissions over `entrypoint.sh`

```bash
chmod +x entrypoint.sh
```

#### 5 - Run docker container for provision

```bash
docker run -it --name aks-provisioner --rm -v "$(pwd)":/app -v "${HOME}/.azure":/app/.azure -e VERBOSITY="-vv" cluster-provider:1.0
```

## Expected Outputs

The following set of resources would be available for the user.