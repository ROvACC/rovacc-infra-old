terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.44.1"
    }
  }
}

provider "google" {
  project = "rovacc-operations"
  region  = "eu-west3"
  zone    = "eu-west3-a"
}
