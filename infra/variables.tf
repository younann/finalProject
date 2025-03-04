variable "terraform_backend_bucket_name" {
  description = "The name of the S3 bucket for Terraform backend"
  type        = string
}

variable "terraform_lock_table_name" {
  description = "The name of the DynamoDB table for Terraform state locking"
  type        = string
}

variable "docker_image" {
  description = "The Docker image to use for the ECS task"
  type        = string
  default     = "nginx:latest"
}

variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default     = "example-ecs-cluster"
}

variable "ecs_service_name" {
  description = "The name of the ECS service"
  type        = string
  default     = "example-ecs-service"
}

variable "task_family" {
  description = "The family name for the ECS task definition"
  type        = string
  default     = "example-app"
}

variable "container_port" {
  description = "The port the container listens on"
  type        = number
  default     = 80
}
