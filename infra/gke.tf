locals {
  prefix = "${var.environment}-${var.name}"
}
resource "google_container_cluster" "kube" {
  name                     = "${local.prefix}-gke"
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false

}

resource "google_container_node_pool" "np" {
  name       = "${var.name}-np"
  cluster    = google_container_cluster.kube.id
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = "e2-standard-2"
  }
}
