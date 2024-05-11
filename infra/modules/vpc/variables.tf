variable "project_id" {
  description = "The ID of the project in which the resource belongs."
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network."
  type        = string
}

variable "location" {
  description = "The location (region or zone) where the VPC and subnetwork should be created."
  type        = string
}

variable "ip_cidr_range" {
  description = "The IP address range of the VPC in CIDR format."
  type        = string
}