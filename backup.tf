resource "google_storage_transfer_job" "backup" {
  count = var.backup_enabled ? 1 : 0

  description = "Nightly backup for bulder-${var.environment}-${var.name}"
  project     = var.google_project
  status      = var.backup_pause

  transfer_spec {
    gcs_data_sink {
      bucket_name = var.backup_location
    }

    transfer_options {
      overwrite_objects_already_existing_in_sink = var.backup_overwrite_existing
      delete_objects_unique_in_sink              = false
      delete_objects_from_source_after_transfer  = false
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