# AKS Deployment

- [AKS Deployment](#aks-deployment)
  - [Architecture](#architecture)
  - [Getting started](#getting-started)
    - [1 - Docker Installation](#1---docker-installation)
    - [2 - Retrieve Azure Credentials](#2---retrieve-azure-credentials)
    - [3 - Build the infrastructure provisioner docker image](#3---build-the-infrastructure-provisioner-docker-image)


This folder contains the `IaC Terraform definition for setting AKS` with just a single CLI utility.

## Architecture

TODO: Include arch diagram


## Getting started

### 1 - Docker Installation

Make sure to have Docker CE installed in your local machine. For further reference, check [Docker Install Official Documentation](https://docs.docker.com/engine/install)

### 2 - Retrieve Azure Credentials



### 3 - Build the infrastructure provisioner docker image

```bash
docker build ../docker -f ../docker/Dockerfile -t cluster-provider:1.0 \
--build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg USER=$(id -un) --build-arg GROUP=$(id -gn)
```


