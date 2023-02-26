resource "google_secret_manager_secret" "discord_bot_token" {
  secret_id = "discor-bot-token-${var.environment}"

  labels = local.labels

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "discord_bot_token" {
  secret      = google_secret_manager_secret.discord_bot_token.id
  secret_data = "NOT_A_REAL_TOKEN"
}

resource "google_secret_manager_secret_iam_binding" "discord_bot_token_iam_binding" {
  secret_id = google_secret_manager_secret.discord_bot_token.secret_id
  role      = "roles/secretmanager.secretAccessor"

  members = [
    "serviceAccount:${google_service_account.cloud_run_v2_service_account.email}"
  ]
}
