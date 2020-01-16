resource "google_project_iam_custom_role" "bulder_bucket_reader" {
  project     = var.google_project
  role_id     = "bulder.storage.reader"
  title       = "Bulder Storage Reader"
  description = "Can list and read, but never write nor delete"
  permissions = ["storage.buckets.get", "storage.buckets.list", "storage.objects.get", "storage.objects.list"]
}

resource "google_project_iam_custom_role" "bulder_bucket_writer" {
  project     = var.google_project
  role_id     = "bulder.storage.writer"
  title       = "Bulder Storage Writer"
  description = "Can write and get, but never delete"
  permissions = ["storage.buckets.get", "storage.buckets.list", "storage.buckets.create", "storage.objects.create", "storage.objects.get", "storage.objects.list"]
}
