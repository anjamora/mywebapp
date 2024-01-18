#define input variables for your Terraform configuration. 
#Input variables allow you to parameterize your Terraform configurations, making them more flexible and reusable.

variable "region"  {
    description = "Default region for provider"
    type        = string
}

#ec2 variables
variable "ami"  {
    description = "Amazon machine image to use for ec2 instance"
    type        = string
}

variable "instance_name"  {
    description = "Name of ec2 instance"
    type        = string
}

variable "instance_type"  {
    description = "ec2 instance type"
    type        = string
}

#S3 variables
variable "bucket_name"  {
    description = "name of s3 bucket for app data"
    type        = string
}

#RDS variables
variable "db_name"  {
    description = "name for database"
    type        = string
}

variable "db_user"  {
    description = "username for database"
    type        = string
}

variable "db_pass"  {
    description = "password for database"
    type        = string
    sensitive   = true
}