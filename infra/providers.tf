terraform {
  backend "remote" {
    organization = "carlos-herrera"
    workspaces {
      name = "equifax-gcp"

    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/google"
      version = "5.28.0"
    }
  }
}

provider "google" {

}