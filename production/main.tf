module "service" {
  source = "../modules/service"

  environment = "production"
  system_id = "rovacc-infra"

}
