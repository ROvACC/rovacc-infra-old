resource "google_pubsub_topic" "rovacc_events_topic" {
  name = "${var.system_id}-${var.environment}-events"

  labels = local.labels

  message_retention_duration = "86600s"
}

resource "google_pubsub_topic" "rovacc_events_dlq" {
  name = "${var.system_id}-${var.environment}-events-dlq"
}

resource "google_pubsub_subscription" "rovacc_events_subscription" {
  name  = "${var.system_id}-${var.environment}-events"
  topic = google_pubsub_topic.rovacc_events_topic.name

  dead_letter_policy {
    dead_letter_topic     = google_pubsub_topic.rovacc_events_dlq.id
    max_delivery_attempts = 10
  }
}

