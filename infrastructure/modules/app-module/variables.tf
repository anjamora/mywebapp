#define input variables for your Terraform configuration. 
#Input variables allow you to parameterize your Terraform configurations, making them more flexible and reusable.

variable "region"  {
    description = "Default region for provider"
    type        = string
    default = "us-east-2"
}

variable "environment_name" {
    description = "Deployment environment"
    type = string
    default = "dev"
}

#ec2 variables
variable "ami"  {
    description = "Amazon machine image to use for ec2 instance"
    type        = string
    default = "ami-0cd3c7f72edd5b06d"
}

variable "instance_name"  {
    description = "Name of ec2 instance"
    type        = string
    default = "webapp"
}

variable "instance_type"  {
    description = "ec2 instance type"
    type        = string
    default = "t2.micro"
}

#S3 variables
variable "bucket_name"  {
    description = "name of s3 bucket for app data"
    type        = string
    default = "anjamora-webapp-data"
}

#RDS variables
variable "db_name"  {
    description = "name for database"
    type        = string
    default = "webapp-db"
}

variable "db_user"  {
    description = "username for database"
    type        = string
    default = "webapp-user"
}

variable "db_pass"  {
    description = "password for database"
    type        = string
    sensitive   = true
}