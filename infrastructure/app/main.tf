# main.tf
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

variable "db_pass"  {
  description = "password for database"
  type = string
  sensitive = true
}

provider "aws" {
  region = "us-east-2" # Set your desired AWS region
}

module "webapp" {
  source = "../app-module"

  #input variables
  region = "us-east-2"
  ami = "ami-0cd3c7f72edd5b06d"
  instance_type = "t2.micro"
  instance_name = "webapp"
  bucket_name = "anjamora-webapp-data"
  db_name = "webapp-db"
  db_user = "webapp-user"
  db_pass = var.db_pass
}