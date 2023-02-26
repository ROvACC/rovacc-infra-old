resource "google_artifact_registry_repository" "discord_bot" {
  location      = var.region
  format        = "DOCKER"
  repository_id = "discord-bot-${var.environment}"
  labels        = local.labels
}
