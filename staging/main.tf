
terraform {
  backend "gcs" {
    bucket = "rovacc-tfstate-staging"
    prefix = "terraform/state"
  }
}

module "service" {
  source = "../modules/service"

  environment = "staging"
  system_id   = "rovacc-infra"
  project = "rovacc-operations"
  region  = "eu-west3"
  zone    = "eu-west3-a"
}
