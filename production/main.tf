
terraform {
  backend "gcs" {
    bucket = "rovacc-tfstate-production"
    prefix = "terraform/state"
  }
}

module "service" {
  source = "../modules/service"

  environment = "production"
  system_id   = "rovacc-infra"

  project = "rovacc-operations"
  region  = "europe-west1"
  zone    = "europe-west1-a"

  discord_bot_token_secret_version = "2"
}
