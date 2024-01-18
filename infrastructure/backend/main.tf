terraform {
# Uncomment this section after applying and run init again
  # backend "s3" {
  #   bucket         = var.bucket_name  # Use the same bucket name
  #   key            = "terraform.tfstate"
  #   region         = var.region       # Update with the same AWS region
  #   encrypt        = true
  #   dynamodb_table = var.dynamodb_table_name   # Optional: Use a DynamoDB table for state locking
  # }

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  region = var.region
}

#S3 state bucket
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name
  force_destroy = true
  
}

resource "aws_s3_bucket_acl" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.bucket
  acl    = "private"
}
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


#lock file to stop multiple applies
resource "aws_dynamodb_table" "terraform_lock" {
  name           = var.dynamodb_table_name  # Update with a unique table name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}