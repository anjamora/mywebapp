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
  region = var.region # Set your desired AWS region
}

#security groups
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

#ec2 isntances
resource "aws_instance" "webapp" {
  ami           = var.ami               #"ami-0cd3c7f72edd5b06d" # Replace with your desired AMI ID
  instance_type = var.instance_type     #"t2.micro"             # Replace with your desired instance type`
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, Maya!" > index.html
              python3 -m http.server 8080 &
              EOF
  tags = {
    Name  = var.instance_name
  }
}

#s3 buckets
resource "aws_s3_bucket" "webapp-data" {
  bucket = var.bucket_name
  force_destroy = true
  
}

resource "aws_s3_bucket_versioning" "webapp-data" {
  bucket = aws_s3_bucket.webapp-data.bucket

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "webapp-data" {
  bucket = aws_s3_bucket.webapp-data.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


