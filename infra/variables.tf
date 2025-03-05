variable "aws_region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = "DevSecOps-eks-cluster"
}

variable "ecr_repo_name" {
  description = "ECR repository name"
  default     = "python-app-repo"
}

variable "s3_bucket_name" {
  description = "S3 bucket for Terraform state or application storage"
  default     = "DevSecOps-eks-app-bucket"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table for Terraform state locking or app storage"
  default     = "DevSecOps-eks-app-table"
}

