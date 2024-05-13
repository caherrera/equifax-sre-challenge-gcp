module "googleapis" {
  source = "./modules/googleapis"
  services = [
    "cloudresourcemanager.googleapis.com",
    "container.googleapis.com",
    "dns.googleapis.com",
    "compute.googleapis.com",
    "containerregistry.googleapis.com",
    "sqladmin.googleapis.com",
    "sql-component.googleapis.com",
    "servicenetworking.googleapis.com"
  ]
}