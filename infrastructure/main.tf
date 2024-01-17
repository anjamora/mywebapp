terraform {
# # Uncomment this section after applying and run init again
#   backend "s3" {
#     bucket         = "anjamora-tf-state"  # Use the same bucket name
#     key            = "terraform.tfstate"
#     region         = "us-east-2"        # Update with the same AWS region
#     encrypt        = true
#     dynamodb_table = "tf-locking"   # Optional: Use a DynamoDB table for state locking
#   }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}


resource "aws_s3_bucket" "terraform_state" {
  bucket = "anjamora-tf-state"
  force_destroy = true
  
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



resource "aws_dynamodb_table" "terraform_lock" {
  name           = "tf-locking"  # Update with a unique table name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}