variable "region" {
  description = "default region for provider"
  type    = string
  default = "us-east-2"
}

variable "bucket_name" {
  description = "name of bucket for state file"
  type    = string
  default = "anjamora-tf-state"
}

variable "dynamodb_table_name" {
  description = "name of table for locking"
  type    = string
  default = "tf-locking"
}
