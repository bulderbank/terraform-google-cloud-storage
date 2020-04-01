resource "google_storage_bucket_iam_member" "iam_read_members" {
  for_each = toset(var.iam_read_members)

  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.objectViewer"
  member = each.key

  depends_on = [google_storage_bucket.bucket]
}

resource "google_storage_bucket_iam_member" "iam_write_members" {
  for_each = toset(var.iam_write_members)

  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.objectCreator"
  member = each.key

  depends_on = [google_storage_bucket.bucket]
}
