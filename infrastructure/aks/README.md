# AKS Deployment

- [AKS Deployment](#aks-deployment)
  - [Architecture](#architecture)
  - [Getting started](#getting-started)
    - [1 - Docker Installation](#1---docker-installation)
    - [2 - Retrieve Azure Credentials](#2---retrieve-azure-credentials)
    - [3 - Build the infrastructure provisioner docker image](#3---build-the-infrastructure-provisioner-docker-image)
      - [4 - Ensure exec permissions over `entrypoint.sh`](#4---ensure-exec-permissions-over-entrypointsh)
      - [5 - Run docker container for provision](#5---run-docker-container-for-provision)
  - [VNet peering](#vnet-peering)
    - [Pre-requisites](#pre-requisites)


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

## VNet peering

> \[!CAUTION\]
> The cluster defined is private. In order to be able to access it the connectivity must come from internal networking. If you have a pre-existing Vnet with VPN configured, follow the next steps to bound those.

Leveraging the utility [vnet_peering](../../scripts/azure/vnet_peering.py), it is easy to set-up the required peering only by setting the required arguments.

### Pre-requisites

1. Python and pip available at your system.

```bash
sudo apt-get update && apt-get install -y python3 python3-pip
```

2. Pipenv installed in the system.

```bash
pip install pipenv
```

> \[!IMPORTANT\]
> Ensure to include the python binaries in the `PATH` if not done already (you will see the warning if that is the case, when launching `pip install`).

3. Move to the script directory:

```bash
cd ../../scripts/azure/
```

4. Install the required dependencies.

```bash
pipenv install
```

5. Run the script from the virtual environment.

```bash
pipenv shell

# Inside the virtual env
python3 vnet_peering_setup.py --cluster_vnet myClusterVNet --cluster_rg myClusterResourceGroup --existing_vnet myExistingVNet --existing_rg myExistingResourceGroup --subscription_id mySubscriptionId
```

> \[!IMPORTANT\]
> Note that the cluster resource group is the **Automatically Generated when creating the cluster, not the one inputted to the terraform**. E.g. `MC_devsecops-cluster_devsecops-cluster_westeurope`

