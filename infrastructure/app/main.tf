# main.tf
terraform {

  #Assumes you have tf-backend built
  #Runinit tf-backend before uncommenting

  # backend "s3" {
  #   bucket         = "anjamora-tf-state"
  #   key            = "app/terraform.tfstate"
  #   region         = "us-east-2"      
  #   encrypt        = true
  #   dynamodb_table = "tf-locking"   
  # }

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

# variable "db_pass"  {
#   description = "password for database"
#   type = string
#   sensitive = true
# }

module "webapp" {
  source = "../modules/app-module"

  #input variables
  region        = "us-east-2"
  ami           = "ami-0cd3c7f72edd5b06d"
  instance_type = "t2.micro"
  instance_name = "webapp"
  bucket_name   = "anjamora-webapp-data"
  db_name       = "webapp-db"
  db_user       = "webapp-user"
  db_pass       = "password"
}

output "instance_ip_addr" {
  value = module.webapp.instance_ip_addr
}

