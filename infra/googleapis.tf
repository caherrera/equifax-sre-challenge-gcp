module "googleapis" {
  source   = "./modules/googleapis"
  services = [
    "container.googleapis.com",
    "dns.googleapis.com",
    "compute.googleapis.com",
    "sqladmin.googleapis.com",
    "loadbalancing.googleapis.com",
    "containerregistry.googleapis.com",
    "networking.googleapis.com"
  ]
}