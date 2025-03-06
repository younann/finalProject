variable "aws_region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = "devsecops-eks-cluster"
}


variable "s3_bucket_name" {
  description = "S3 bucket for Terraform state or application storage"
  default     = "DevSecOps-eks-app-bucket"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table for Terraform state locking or app storage"
  default     = "DevSecOps-eks-app-table"
}

