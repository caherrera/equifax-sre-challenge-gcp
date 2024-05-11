/**
 * # Google Compute Instance for Bastion
 *
 * Terraform module that create a single
 * compute instance in Google Cloud Platform (GCP)
 * with the following features:
 * - No external IP
 * - Custom SSH keys
 * - Custom machine type
 *
 */

locals {
  ssh_keys = join("\n", [for key in var.ssh_keys : "${key.user}:${key.publickey}"])

}
resource "google_compute_instance" "bastion" {
  count        = var.create ? var.instances : 0
  name         = var.instance_name
  machine_type = var.machine_type
  project      = var.project

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    subnetwork = var.subnet

  }

  metadata = {
    ssh-keys = local.ssh_keys
  }

  allow_stopping_for_update = true
}