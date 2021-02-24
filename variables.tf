variable "environment" {}

variable "google_project" {}

variable "google_region" {}

variable "name" {
  type = string
}

variable "storage_class" {
  type    = string
  default = "REGIONAL"
}

variable "versioning" {
  type    = bool
  default = false
}

variable "object_retention" {
  type    = list(number)
  default = []
}

variable "archive_rule" {
  type    = map(any)
  default = {}
}

variable "delete_rule" {
  type    = map(any)
  default = {}
}

variable "iam_read_members" {
  type    = list(string)
  default = []
}

variable "iam_write_members" {
  type    = list(string)
  default = []
}

variable "backup_enabled" {
  type    = bool
  default = false
}

variable "backup_sa_email" {
  type    = string
  default = ""
}

variable "backup_pause" {
  type    = string
  default = "ENABLED"
}

variable "backup_overwrite_existing" {
  type    = bool
  default = false
}

locals {
  location = var.google_region
  labels = {
    created-with = "terraform"
    environment  = var.environment
  }
}
