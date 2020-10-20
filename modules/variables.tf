variable "cluster_name" {
  description = "Name of GKE cluster"
  type        = string
  default     = ""
}

variable "cluster_location" {
  description = "Cluster location"
  type        = string
  default     = "asia-southeast1-a"
}

variable "cluster_network" {
  description = "Network"
  type        = string
  default     = "default"
}

variable "cluster_subnet" {
  description = "Subnet"
  type        = string
  default     = "default"
}

variable "cluster_preemptible" {
  description = "Preemptible flag"
  type        = bool
  default     = false
}

variable "cluster_oauth_scopes" {
    type       = list(string)
    default    = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
}

variable "node_pools" {
  type = list(object({
    pool_name    = string
    pool_size    = number
    machine_type = string
    tags         = list(string)
    label        = map(string)
  }))

  default = []
}