

/*
provider "aws" {
  region = var.aws_region
}

# Create a VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "eks-vpc"
  cidr   = var.vpc_cidr
  
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  enable_nat_gateway = true
}

# Create an EKS Cluster
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  
  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id
  
  node_groups = {
    eks_nodes = {
      desired_capacity = var.desired_capacity
      max_capacity     = var.max_capacity
      min_capacity     = var.min_capacity

      instance_types = var.instance_types
    }
  }
}

# Deploy Kubernetes resources
resource "null_resource" "deploy_python_app" {
  depends_on = [module.eks]

  provisioner "local-exec" {
    command = <<EOT
      aws eks --region ${var.aws_region} update-kubeconfig --name ${var.cluster_name}
      kubectl apply -f https://raw.githubusercontent.com/younann/finalProject/main/k8s/deployment.yaml
    EOT
  }
}
*/
