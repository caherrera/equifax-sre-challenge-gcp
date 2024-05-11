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
  }
}

provider "google" {

}