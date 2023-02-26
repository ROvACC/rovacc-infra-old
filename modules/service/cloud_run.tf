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
            version = "4"
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
}

resource "google_service_account" "cloud_run_v2_service_account" {
  account_id = "cloud-run-discord-bot-${var.environment}"
}

/* resource "google_cloud_run_v2_service_iam_member" "discord_bot" { */
/*   name     = google_cloud_run_v2_service.discord_bot.name */
/*   location = google_cloud_run_v2_service.discord_bot.location */
/*   role     = "roles/secretmanager.secretAccessor" */
/*   member   = "serviceAccount:${data.google_service_account.service_account.email}" */
/* } */
