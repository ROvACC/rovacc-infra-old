module "service" {
  source = "../modules/service"

  environment = "staging"
  system_id = "rovacc-infra"
}
