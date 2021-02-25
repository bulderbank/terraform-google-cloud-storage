resource "google_storage_bucket_iam_member" "backup_viewer" {
  count = var.environment == "prod" && var.backup_enabled ? 1 : 0

  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${var.backup_sa_email}"
}

resource "google_storage_transfer_job" "backup" {
  count = var.environment == "prod" && var.backup_enabled ? 1 : 0

  description = "Nightly backup for ${var.name}"
  project     = var.google_project
  status      = var.backup_pause

  transfer_spec {
    gcs_data_source {
      bucket_name = google_storage_bucket.bucket.name
    }

    gcs_data_sink {
      bucket_name = "backup-${google_storage_bucket.bucket.name}"
    }

    transfer_options {
      overwrite_objects_already_existing_in_sink = var.backup_overwrite_existing
      delete_objects_unique_in_sink              = false
      delete_objects_from_source_after_transfer  = false
    }

    object_conditions {
      max_time_elapsed_since_last_modification = "86400s"
    }
  }

  schedule {
    schedule_start_date {
      year  = 2021
      month = 1
      day   = 1
    }
    start_time_of_day {
      hours   = 03
      minutes = 00
      seconds = 0
      nanos   = 0
    }
  }

  depends_on = [google_storage_bucket.bucket]
}
