terraform {
  required_providers {
    google = "3.4.0"
  }
}

resource "google_container_node_pool" "gke_pool" {
  name       = var.pool_name
  location   = var.cluster_location
  cluster    = google_container_cluster.gke_cluster.name
  node_count = var.pool_node_count

  node_config {
    preemptible  = var.cluster_preemptible
    machine_type = var.cluster_machine_type

    metadata = {
      disable-legacy-endpoints = true
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {}
    tags = var.cluster_node_tags    
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

  timeouts {
    create = "30m"
    update = "40m"
  }
}