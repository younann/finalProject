output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "The security group ID of the EKS cluster"
  value       = module.eks.cluster_security_group_id
}

output "node_group_name" {
  description = "The name of the EKS managed node group"
  value       = var.node_group_name
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "The IDs of the private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "The IDs of the public subnets"
  value       = module.vpc.public_subnets
}
