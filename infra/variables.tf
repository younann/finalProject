# variables.tf
variable "terraform_backend_bucket_name" {
  description = "S3 bucket name for Terraform state"
  type        = string
  default     = "my-terraform-state-bucket" # Add a default value
}

variable "terraform_lock_table_name" {
  description = "DynamoDB table name for state locking"
  type        = string
  default     = "my-terraform-lock-table" # Add a default value
}

variable "docker_image" {
  description = "Docker image URL for ECS container"
  type        = string
  default     = "my-docker-repo/my-python-app:latest" # Add a default value
}

