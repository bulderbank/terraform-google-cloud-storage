resource "google_storage_bucket" "bucket" {
  name          = "${var.name}-${var.environment}"
  project       = var.google_project
  location      = local.location
  storage_class = var.storage_class

  dynamic "retention_policy" {
    for_each = var.backup_retention
    content {
      retention_period = retention_policy.value
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.delete_rule
    content {
      action {
        type = "Delete"
      }
      condition {
        age        = lifecycle_rule.value["age"]
        with_state = lifecycle_rule.value["with_state"]
      }
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.archive_rule
    content {
      action {
        type          = "SetStorageClass"
        storage_class = lifecycle_rule.value["archive_class"]
      }
      condition {
        age                   = lifecycle_rule.value["age"]
        with_state            = lifecycle_rule.value["with_state"]
        matches_storage_class = lifecycle_rule.value["target_class"]
      }
    }
  }

  labels = local.labels
}
