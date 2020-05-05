created_on = "2020-01-06"
created_by = "fredrick-myrvoll"

environment    = "dev"
google_project = "module-dev"
google_region  = "europe-north1"

name = "example-slim"

storage_class = "STANDARD"
object_retention = [604800]

archive_rule = {
  archive_after_7_days = {
    age        = 7
    with_state = "LIVE"
    target_class = ["STANDARD"]
    archive_class = "COLDLINE"
  }
}

delete_rule = {
  delete_after_14_days = {
    age        = 14
    with_state = "ARCHIVED"
  }
}

iam_read_members = [
  "user:example@reader.com",
  "serviceaccount:example@reader2.com",
]

iam_write_members = [
  "user:example@writer.com",
  "serviceaccount:example@writer2.com",
]
