terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.53.1"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
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

locals {
  labels = {
    system_id     = var.system_id
    environment   = var.environment
    provisined_by = "terraform"
  }
}
