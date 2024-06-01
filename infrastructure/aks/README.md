# AKS Deployment

- [AKS Deployment](#aks-deployment)
  - [Architecture](#architecture)
  - [Getting started](#getting-started)
    - [1 - Docker Installation](#1---docker-installation)
    - [2 - Retrieve Azure Credentials](#2---retrieve-azure-credentials)
    - [3 - Build the infrastructure provisioner docker image](#3---build-the-infrastructure-provisioner-docker-image)
    - [4 - Ensure exec permissions over `entrypoint.sh`](#4---ensure-exec-permissions-over-entrypointsh)
    - [5 - Run docker container for provision](#5---run-docker-container-for-provision)
  - [Connection to the cluster](#connection-to-the-cluster)
  - [Cluster exposure](#cluster-exposure)
  - [VNet peering](#vnet-peering)
    - [Pre-requisites](#pre-requisites)
  - [DNS Zone link](#dns-zone-link)


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
az login --use-device-code --tenant <TENANT_ID>
```

### 3 - Build the infrastructure provisioner docker image

```bash
docker build ../docker -f ../docker/Dockerfile.provisioner -t cluster-provider:1.0 \
--build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg USER=$(id -un) --build-arg GROUP=$(id -gn)
```

### 4 - Ensure exec permissions over `entrypoint.sh`

```bash
chmod +x entrypoint.sh
```

> \[!IMPORTANT\]
> (WIP) By default, this entrypoint generates the cluster provisioning process. If you want to restart the process from scratch or delete everything and start over, replace `aks.yml` with `aks_destroy.yml` in the `entrypoint.sh` script.

### 5 - Run docker container for provision

```bash
docker run -it --name aks-provisioner --rm -v "$(pwd)":/app -v "${HOME}/.azure":/app/.azure -e VERBOSITY="-vv" cluster-provider:1.0
```

## Connection to the cluster

After the deployment, you can connect to the cluster by completing the following steps:

1. Install `kubectl`, `kubelogin` and `az` CLI tools.
2. (Only if needed) Setup your azure account:

```bash
az account set --subscription <SUBSCRIPTION_ID>
```

3. Retrieve the credentials for the cluster:

```bash
az aks get-credentials --resource-group <RESOURCE_GROUP> --name <CLUSTER_NAME>
```

4. Check the connection to the cluster:

```bash
kubectl get nodes
```

## Cluster exposure

By default, `private_cluster_enabled` property is set to `true`. This means that the cluster is not exposed to the internet. If you want to expose it, you can set the property to `false` in `envVars` file.

Since the property `public_network_access_enabled` is deprecated and no longer supported by Azure API, the AKS will be created with the `public_network_access_enabled` property set to `true` by default. If your security requirements do not allow this, you can execute the following command to disable it:

```bash
az aks update --resource-group <RESOURCE_GROUP> --name <CLUSTER_NAME> --disable-public-network
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


## DNS Zone link

If you want to link the vnet to a private DNS Zone, you can use the following command:

```bash
VNET_ID=$(az network vnet show -g rg-network -n MyVNet --query "id" -o tsv)

az network private-dns link vnet create \
  -g rg-dns \
  -n MyDNSLink \
  -z $DNS_ZONE_ID \
  -v $VNET_ID \
  -e True
```

