# main.tf

# backend.tf

terraform {
#   backend "s3" {
#     bucket         = "anjamora-tf-state" # Replace with your S3 bucket name
#     key            = "terraform.tfstate"   # Replace with your desired path in the bucket
#     region         = "us-east-2"                   # Replace with your desired AWS region
#     encrypt        = true
#     dynamodb_table = "tf-locking"             # Replace with your DynamoDB table name for state locking
#   }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}



provider "aws" {
  region = "us-east-2" # Set your desired AWS region
}

resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow inbound HTTP traffic"
  
  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web01" {
  ami           = "ami-0cd3c7f72edd5b06d" # Replace with your desired AMI ID
  instance_type = "t2.micro"             # Replace with your desired instance type`
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World! 1" > index.html
              python3 -m http.server 8080 &
              EOF
}

resource "aws_s3_bucket" "webapp-db" {
  bucket = "anjamora-webapp-db"
  force_destroy = true
  
}

# resource "aws_s3_bucket_acl" "webapp-db" {
#   bucket = aws_s3_bucket.webapp-db.bucket
#   acl    = "private"
# }
resource "aws_s3_bucket_versioning" "webapp-db" {
  bucket = aws_s3_bucket.webapp-db.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "webapp-db" {
  bucket = aws_s3_bucket.webapp-db.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

