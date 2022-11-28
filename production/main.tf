
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

}
