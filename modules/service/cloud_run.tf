resource "google_cloud_run_v2_service" "discord_bot" {
  name     = "discord-bot-${var.environment}"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_INTERNAL_ONLY"
  labels   = local.labels

  template {
    service_account = google_service_account.cloud_run_v2_service_account.email
    scaling {
      min_instance_count = 1
      max_instance_count = 1
    }
    containers {
      image = "europe-west1-docker.pkg.dev/${var.project}/discord-bot/${var.environment}"
      env {
        name = "DISCORD_TOKEN"
        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.discord_bot_token.secret_id
            version = var.discord_bot_token_secret_version
          }
        }
      }
      env {
        name  = "ROVACC_CORE_ENDPOINT"
        value = "https://core.rovacc.ro/"
      }
      liveness_probe {
        http_get {
          path = "/healthz"
        }
      }
    }
  }
  depends_on = [
    google_service_account.cloud_run_v2_service_account,
  ]
}

resource "google_service_account" "cloud_run_v2_service_account" {
  account_id = "cr-discord-bot-${var.environment}"
}
