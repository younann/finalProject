variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "terraform_backend_bucket_name" {
  description = "The name of the S3 bucket for Terraform backend"
  type        = string
  default     = "your-terraform-backend-bucket"
}

variable "terraform_lock_table_name" {
  description = "The name of the DynamoDB table for Terraform state locking"
  type        = string
  default     = "terraform-lock"
}

variable "docker_image" {
  description = "The Docker image to use for the ECS task"
  type        = string
  default     = "nginx:latest"  # Replace with your Docker image
}
