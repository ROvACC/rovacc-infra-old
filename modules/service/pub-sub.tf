resource "google_pubsub_topic" "rovacc_events" {
  name = "${var.system_id}-${var.environment}-events"

  labels = {
    system_id = "rovacc-infra"
  }

  message_retention_duration = "86600s"
}