variable "region" {
  type    = string
  default = "us-central1"
}
variable "zone" {
  type    = string
  default = "us-central1-a"
}
variable "project" {
  type    = string
  default = "equifax-423021"
}
packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "~> 1"
    }
    ansible = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "googlecompute" "ubuntu" {
  region        = var.region
  zone          = var.zone
  project_id    = var.project
  ssh_username  = "packer"
  source_image  = "ubuntu-2404-noble-amd64-v20240423"

}

build {
  name    = "bastion-ubuntu-{{timestamp}}"
  sources = [
    "source.googlecompute.ubuntu"
  ]

  provisioner "ansible" {
    playbook_file = "playbook.yml"
    #     user          = "/"
  }


}

