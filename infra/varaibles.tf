variable "region" {
  description = "The GCP region to deploy to"
  default     = ""
}

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

variable "az_count" {
  description = "Number of AZs to cover in a given GCP region"
  default     = 2
}

