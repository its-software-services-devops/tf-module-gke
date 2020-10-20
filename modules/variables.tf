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

variable "cluster_node_tags" {
  type    = list(string)
  default = []
}

variable "cluster_network" {
  description = "Network"
  type        = string
  default     = "default"
}

variable "cluster_machine_type" {
  description = "Machine type"
  type        = string
  default     = "n1-standard-1"
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

variable "pool_name" {
  description = "Pool name"
  type        = string
  default     = ""
}

variable "pool_node_count" {
  description = "Pool node count"
  type        = number
  default     = 3
}