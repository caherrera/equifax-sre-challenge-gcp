resource "google_compute_network" "vpc" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.network_name}-subnet"
  project       = var.project_id
  ip_cidr_range = var.ip_cidr_range
  region        = var.location
  network       = google_compute_network.vpc.self_link
}

resource "google_compute_router" "default" {
  name    = "${var.network_name}-router"
  region  = var.location
  network = google_compute_network.vpc.name
  project = var.project_id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "default" {
  name   = "${var.network_name}-nat"
  router = google_compute_router.default.name
  region = google_compute_router.default.region
  project = var.project_id

  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}