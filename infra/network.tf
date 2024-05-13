data "google_compute_network" "primary" {
  name = "default"
}

data "google_compute_subnetwork" "snet" {
  name   = "default"
  region = var.region
}

resource "google_compute_global_address" "google-managed-services" {
  name          = "google-managed-services"
  description   = "IP allocation for Google managed services (Cloud SQL, etc)"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = data.google_compute_network.primary.id
}

resource "google_service_networking_connection" "google-managed-services" {
  provider = google-beta
  network  = data.google_compute_network.primary.id
  service  = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.google-managed-services.name
  ]
}