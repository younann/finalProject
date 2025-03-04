provider "aws" {
  region = var.region
}

# Create a VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.region}a", "${var.region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Create an EKS cluster
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.30.2"

  cluster_name    = var.cluster_name
  cluster_version = "1.24"

  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.private_subnets
  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  eks_managed_node_groups = {
    (var.node_group_name) = {
      desired_capacity = var.desired_size
      max_capacity     = var.max_size
      min_capacity     = var.min_size

      instance_types = [var.instance_type]
      capacity_type  = "ON_DEMAND"
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
