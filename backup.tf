data "google_storage_transfer_project_service_account" "default" {
  project = var.google_project
}

resource "google_storage_bucket_iam_member" "backup_viewer" {
  count = !var.environment == "test" && var.backup_enabled ? 1 : 0

  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${data.google_storage_transfer_project_service_account.default.email}"
}

resource "google_storage_transfer_job" "backup" {
  count = !var.environment == "test" && var.backup_enabled ? 1 : 0

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

output "backup_sa_email" {
  value       = data.google_storage_transfer_project_service_account.default.email
  description = "Default service account for GCS transfer service"
}
