# Run this at the beginning : export GOOGLE_CREDENTIALS="D:/dev/keys/its-artifact-commons-6eb8e8c315b3.json"

terraform {
  required_providers {
    google = "~> 3.4.0"
  }

  backend "gcs" {
    bucket  = "its-terraform-states"
    prefix  = "tf-module-gke"
  } 
}

provider "google" {
  project     = "its-artifact-commons"
  region      = "asia-southeast1"
  credentials = file("D:/dev/keys/its-artifact-commons-6eb8e8c315b3.json")
}

module "gke-cluster-00" {
  source             = "../modules"
  cluster_name       = "terraform-gke-module-test"
  node_pools         = [
        {pool_name="db",  pool_size=1, machine_type="e2-medium", tags=["database"], label={"role"="database"}},
        {pool_name="ing", pool_size=1, machine_type="e2-medium", tags=["ingress"], label={"role"="ingress"}}
      ]
}