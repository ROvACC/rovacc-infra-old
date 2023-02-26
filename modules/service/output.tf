output "secret_import_path" {
  value = google_secret_manager_secret.discord_bot_token.name
}
