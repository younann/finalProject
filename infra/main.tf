provider "aws" {
  region = "us-east-1" # Change to your preferred region
}

# Create a VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "eks-vpc"
  cidr   = "10.0.0.0/16"
  
  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_nat_gateway = true
}

# Create an EKS Cluster
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-eks-cluster"
  cluster_version = "1.27"
  
  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id
  
  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_types = ["t3.medium"]
    }
  }
}

# Deploy Kubernetes resources
resource "null_resource" "deploy_python_app" {
  depends_on = [module.eks]

  provisioner "local-exec" {
    command = <<EOT
      aws eks --region us-east-1 update-kubeconfig --name my-eks-cluster
      kubectl apply -f https://github.com/younann/finalProject/blob/main/k8s/deployment.yaml
  }
}
