variable "create" {
  description = "Set to true to create the VM"
  type        = bool
  default     = true
}

variable "instances" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}
variable "instance_name" {
  description = "Name of the VM"
  type        = string
  default     = "bastion-vm"
}
variable "ssh_keys" {
  type = list(object({
    publickey = string
    user      = string
  }))
  description = "list of public ssh keys that have access to the VM"
  default     = []
}

variable "image" {
  default = "debian-12-bookworm-v20240415"
}

variable "machine_type" {
  description = "Machine type to deploy"
  default = "e2-micro"
}

variable "region" {
  description = "Region to deploy the VM in"
  default = "us-east4"
}

variable "subnet" {
  description = "Subnet to deploy the VM in"
  type = string

}

variable "project" {
  description = "Project to deploy the VM in., If empty it will use the default project"
  type    = string
  default = ""
}