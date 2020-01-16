resource "google_storage_bucket_iam_member" "iam_read_members" {
  for_each = toset(var.iam_read_members)

  bucket = google_storage_bucket.bucket.name
  role   = "projects/${google_project_iam_custom_role.bulder_bucket_reader.project}/roles/${google_project_iam_custom_role.bulder_bucket_reader.role_id}"
  member = each.key

  depends_on = [google_storage_bucket.bucket, google_project_iam_custom_role.bulder_bucket_reader]
}

resource "google_storage_bucket_iam_member" "iam_write_members" {
  for_each = toset(var.iam_write_members)

  bucket = google_storage_bucket.bucket.name
  role   = "projects/${google_project_iam_custom_role.bulder_bucket_writer.project}/roles/${google_project_iam_custom_role.bulder_bucket_writer.role_id}"
  member = each.key

  depends_on = [google_storage_bucket.bucket, google_project_iam_custom_role.bulder_bucket_writer]
}
