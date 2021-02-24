# Google Cloud Storage

Made for Terraform 0.12.x

### Code examples

#### Required arguments and variables

```hcl
module "bucket_example_slim" {
  source = "github.com/bulderbank/terraform-google-cloud-storage"

  environment    = var.environment
  google_project = var.google_project
  google_region  = var.google_region

  name = "bulder-${var.environment}-example-slim"
}
```

#### All arguments and variables enabled

```hcl
module "bucket_example" {
  source = "github.com/bulderbank/terraform-google-cloud-storage"

  environment    = var.environment
  google_project = var.google_project
  google_region  = var.google_region

  name = "bulder-${var.environment}-example-slim"

  storage_class = "STANDARD"                // Can be omitted, defaults to REGIONAL
  versioning = true                         // Can be omitted, will create new versions instead of overwriting objects in bucket
  object_retention = [604800]               // Can be omitted, How long to keep objects before they can be modified in seconds

  backup_enabled = true                     // Enables nightly backup at 03:00
  backup_pause = "DISABLE"                  // Temporary pause the backup job
  backup_sa_email = "example@sa.com"        // Default service account for GCS transfer jobs
  backup_overwrite_existing = true          // Replace objects in backup bucket

  archive_rule = {                          // Can be omitted, move files to another storage_class after x days
    archive_after_7_days = {
      age        = 7                        // Days in integer
      with_state = "LIVE"                   // Options are "LIVE", "ARCHIVED", "ANY"
      target_class = ["STANDARD"]           // Which storage_classes to target for archiving
      archive_class = "COLDLINE"            // What type of storage_class to move files to
    }
  }

  delete_rule = {                           // Can be omitted, deletes files after x days
    delete_after_14_days = {
      age        = 14                       // Days in integer
      with_state = "ARCHIVED"               // Which storage_class to target for deletion, options are "LIVE", "ARCHIVED", "ANY"
    }
  }

  iam_read_members = [                      // Can be omitted
    "user:example@reader.com",
    "serviceaccount:example@reader2.com",
  ]

  iam_write_members = [                     // Can be omitted
    "user:example@writer.com",
    "serviceaccount:example@writer2.com",
  ]
}
```
