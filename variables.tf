variable "environment" {}

variable "created_by" {}

variable "created_on" {}

variable "google_project" {}

variable "google_region" {}

variable "name" {
  type = string
}

variable "storage_class" {
  type    = string
  default = "REGIONAL"
}

variable "backup_retention" {
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

locals {
  location = var.google_region
  labels = {
    created-with = "terraform"
    created-by   = var.created_by
    created-on   = var.created_on
    environment  = var.environment
  }
}
