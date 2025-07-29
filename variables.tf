# If you want to use variables instead of hardcoded names
variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "bucket_name" {
  description = "Unique S3 bucket name"
  type        = string
}

variable "environment" {
  description = "Environment name like dev or prod"
  type        = string
}
