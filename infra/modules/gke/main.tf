variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "cluster_name" {
  description = "The name of the GKE cluster."
  type        = string
}

variable "location" {
  description = "The location (region or zone) in which the cluster master will be created."
  type        = string
}

variable "network_self_link" {
  description = "The self-link of the VPC network."
  type        = string
}

variable "subnetwork_self_link" {
  description = "The self-link of the subnetwork."
  type        = string
}

variable "machine_type" {
  description = "The machine type for the nodes."
  default     = "n1-standard-4"
}

variable "disk_type" {
  description = "The disk type for the nodes."
  default     = "pd-standard"
}

variable "disk_size_gb" {
  description = "The disk size in GB for the nodes."
  default     = 200
}

# Define the cluster
resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  project            = var.project_id
  location           = var.location
  initial_node_count = 1
  network            = var.network_self_link
  subnetwork         = var.subnetwork_self_link
  remove_default_node_pool = true
  enable_shielded_nodes = true # Shielded nodes protect against rootkits and bootkits
  enable_legacy_abac = false # enable RBAC to enforce least-privilege access
  logging_service    = "logging.googleapis.com/kubernetes" # enable audit logging to keep a record of the activities within the cluster
  monitoring_service = "monitoring.googleapis.com/kubernetes" # enable audit logging to keep a record of the activities within the cluster
  
  network_policy {
    enabled  = true
    provider = "CALICO"
  }
  
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  ip_allocation_policy {
    # These could be specific ranges for your pods and services
    # or you can let Google manage them for you by omitting them
    cluster_ipv4_cidr_block  = "/19"
    services_ipv4_cidr_block = "/22"
  }
  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = [
        "34.228.154.221/32",
        "174.129.36.233/32",
        "3.220.246.53/32",
        "34.231.182.47/32",
        "107.20.58.114/32",
        "44.217.42.116/32",
        "52.54.61.57/32",
        "18.213.60.205/32",
      ]
      content {
        cidr_block   = cidr_blocks.value
        display_name = "Quay.io IP"
      }
    }
    # cidr_blocks {
    #   cidr_block   = "192.168.0.0/28"
    #   display_name = "Corporate"
    # }
    cidr_blocks {
      cidr_block   = "47.202.147.74/32"
      display_name = "My Public IP"
    }
    cidr_blocks {
      cidr_block   = "35.231.242.36/32"
      display_name = "GCP Console external"
    }
  }
}

# Define the node pool separately
resource "google_container_node_pool" "primary_pool" {
  name       = format("%s-%s", google_container_cluster.primary.name, "pool")
  project    = var.project_id
  location   = var.location
  cluster    = google_container_cluster.primary.name

  node_config {
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb
    disk_type    = var.disk_type

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  autoscaling {
    min_node_count = 2
    max_node_count = 2
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
  

  initial_node_count = 2
}

# Output the cluster endpoint and cluster master auth data
output "cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "cluster_master_auth" {
  value = google_container_cluster.primary.master_auth
}