variable "domain" {
  description = "The domain to deploy to"
  default     = "my-wordpress-app.com"
}

variable "name" {
  description = "The name of the application"
  default     = "wordpress"
}

variable "environment" {
  description = "The environment to deploy to"
  default     = "dev"
}

variable "region" {
  description = "The GCP region to deploy to"
  default     = "us-central1"
}

variable "dns_zone" {
  description = "The DNS zone to deploy to"
  default     = "my-wordpress-app.com."
}

variable "zone" {
  description = "The GCP zone"
  default     = "us-central1-a" // Replace this with your default zone
}

variable "project_id" {
  description = "The GCP project"
  default     = "my-wordpress-app"
}