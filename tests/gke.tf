#### NOT YET TEST !!!! ####
locals {
  project = "its-artifact-commons"
  region = "us-west1"

  cluster_name = "yru-openedx-prod-1"
  network_name = "team-a-vpc-network"
  kubernetes_version = "1.20.9-gke.700"
  nodes_subnetwork_name = "team-a-vpc-network"
  pods_secondary_ip_range_name = ""
  services_secondary_ip_range_name = ""
  master_ipv4_cidr_block = "10.128.254.0/28"
}

#### Cluster ####
module "yru-openedx-prod-cluster" {
  source = "./modules"

  name                             = local.cluster_name
  region                           = local.region
  #project                          = local.project
  kubernetes_version               = local.kubernetes_version
  network_name                     = local.network_name
  nodes_subnetwork_name            = local.nodes_subnetwork_name
  pods_secondary_ip_range_name     = local.pods_secondary_ip_range_name
  services_secondary_ip_range_name = local.services_secondary_ip_range_name
  enable_shielded_nodes            = true

  # private cluster options
  enable_private_endpoint = false
  enable_private_nodes    = true
  master_ipv4_cidr_block  = local.master_ipv4_cidr_block

  master_authorized_network_cidrs = [
    {
      # This is the module default, but demonstrates specifying this input.
      cidr_block   = "0.0.0.0/0"
      display_name = "from the Internet"
    },
  ]
}