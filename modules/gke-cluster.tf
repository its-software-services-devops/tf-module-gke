terraform {
  required_providers {
    google = "3.4.0"
  }
}

resource "google_container_node_pool" "gke_pool" {
  count      = length(var.node_pools)

  name       = var.node_pools[count.index].pool_name
  node_count = var.node_pools[count.index].pool_size

  location   = var.cluster_location
  cluster    = google_container_cluster.gke_cluster.name
  

  node_config {
    preemptible  = var.cluster_preemptible
    machine_type = var.node_pools[count.index].machine_type

    metadata = {
      disable-legacy-endpoints = true
    }

    oauth_scopes = var.cluster_oauth_scopes

    labels = var.node_pools[count.index].label
    tags = var.node_pools[count.index].tags
  }
}

resource "google_container_cluster" "gke_cluster" {
  name               = var.cluster_name
  location           = var.cluster_location
  initial_node_count = 1
  remove_default_node_pool = true

  network    = var.cluster_network
  subnetwork = var.cluster_subnet

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  private_cluster_config {
    enable_private_nodes  = true
    enable_private_endpoint = false
    master_ipv4_cidr_block = "192.168.0.0/28"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = ""
    services_secondary_range_name = ""
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}