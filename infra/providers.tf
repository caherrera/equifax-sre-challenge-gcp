terraform {
  backend "remote" {
    organization = "carlos-herrera"
    workspaces {
      name = "equifax-gcp"

    }
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.25.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.30.0"
    }
  }
}

provider "google" {
  region = var.region

}