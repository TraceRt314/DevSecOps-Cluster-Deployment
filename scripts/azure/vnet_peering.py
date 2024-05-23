import argparse
import logging
from azure.identity import DefaultAzureCredential
from azure.mgmt.network import NetworkManagementClient
from halo import Halo

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

def create_vnet_peering(network_client, resource_group_name, vnet_name, peering_name, remote_vnet_id):
    spinner = Halo(text=f"Creating peering {peering_name} from {vnet_name} to remote VNet", spinner="dots")
    spinner.start()

    try:
        async_peering_creation = network_client.virtual_network_peerings.begin_create_or_update(
            resource_group_name,
            vnet_name,
            peering_name,
            {
                "remote_virtual_network": {
                    "id": remote_vnet_id
                },
                "allow_virtual_network_access": True,
                "allow_forwarded_traffic": True,
                "allow_gateway_transit": False,
                "use_remote_gateways": False
            }
        )
        peering_result = async_peering_creation.result()
        spinner.succeed(f"Successfully created peering {peering_name} from {vnet_name} to remote VNet")
        return peering_result
    except Exception as e:
        spinner.fail(f"Failed to create peering {peering_name} from {vnet_name} to remote VNet: {e}")
        raise

def main(cluster_vnet, cluster_rg, existing_vnet, existing_rg, subscription_id):
    logging.info("Starting the VNet peering setup process")
    
    credential = DefaultAzureCredential()
    network_client = NetworkManagementClient(credential, subscription_id)

    # Get the VNet IDs
    cluster_vnet_id = f"/subscriptions/{subscription_id}/resourceGroups/{cluster_rg}/providers/Microsoft.Network/virtualNetworks/{cluster_vnet}"
    existing_vnet_id = f"/subscriptions/{subscription_id}/resourceGroups/{existing_rg}/providers/Microsoft.Network/virtualNetworks/{existing_vnet}"
    
    logging.info(f"Cluster VNet ID: {cluster_vnet_id}")
    logging.info(f"Existing VNet ID: {existing_vnet_id}")

    # Create peering from cluster VNet to existing VNet
    create_vnet_peering(network_client, cluster_rg, cluster_vnet, "ClusterToExistingVNetPeering", existing_vnet_id)
    # Create peering from existing VNet to cluster VNet
    create_vnet_peering(network_client, existing_rg, existing_vnet, "ExistingToClusterVNetPeering", cluster_vnet_id)

    logging.info("VNet peering setup process completed successfully")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Setup VNet peering and routing between two VNets.")
    parser.add_argument("--cluster_vnet", required=True, help="The name of the cluster VNet")
    parser.add_argument("--cluster_rg", required=True, help="The resource group of the cluster VNet")
    parser.add_argument("--existing_vnet", required=True, help="The name of the existing VNet")
    parser.add_argument("--existing_rg", required=True, help="The resource group of the existing VNet")
    parser.add_argument("--subscription_id", required=True, help="The subscription ID")

    args = parser.parse_args()
    main(args.cluster_vnet, args.cluster_rg, args.existing_vnet, args.existing_rg, args.subscription_id)
