resource "google_dns_managed_zone" "zone" {
  dns_name = var.dns_zone
  name     = var.dns_zone
}

