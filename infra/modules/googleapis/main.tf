/**
 * # Google Project Service Enabler
 *
 * Terraform module that allows management of a single
 * API service for a Google Cloud Platform project.
 *
 */

locals {
  project  = var.project == "" ? null : var.project
  services = {for service in var.services : service => service}

}

resource "google_project_service" "project" {
  project  = local.project
  for_each = local.services
  service  = each.value

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}