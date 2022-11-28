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

resource "google_storage_bucket" "tfstate" {
  name          = "rovacc-tfstate-${var.environment}"
  force_destroy = false
  location      = "EU"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}
