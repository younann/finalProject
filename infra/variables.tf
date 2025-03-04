variable "aws_region" {
  description = "AWS region for resources"
  default     = "us-east-1"
}

variable "terraform_backend_bucket_name" {
  description = "S3 bucket name for Terraform state"
  type        = string
}

variable "terraform_lock_table_name" {
  description = "DynamoDB table name for state locking"
  type        = string
}

variable "docker_image" {
  description = "Docker image URL for ECS container"
  type        = string
}

