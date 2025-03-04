provider "aws" {
  region = var.aws_region
}

# IAM Role for EC2 with SSM Access
resource "aws_iam_role" "ssm_role" {
  name = "ssm-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "ssm-profile"
  role = aws_iam_role.ssm_role.name
}

# EC2 Instance
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
}

# VPC Module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "eks-vpc"
  cidr   = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  enable_nat_gateway = true
  
  flow_log_cloudwatch_log_group_name = "vpc-flow-logs"
  flow_log_cloudwatch_iam_role_arn   = aws_iam_role.vpc_flow_log_role.arn
}

resource "aws_iam_role" "vpc_flow_log_role" {
  name = "vpc-flow-log-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "vpc-flow-logs.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "vpc_flow_log_attachment" {
  role       = aws_iam_role.vpc_flow_log_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

# EKS Cluster
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.33.1"
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id

  eks_managed_node_groups = {
    eks_nodes = {
      desired_size = var.desired_capacity
      max_size     = var.max_capacity
      min_size     = var.min_capacity
      instance_types = var.instance_types
    }
  }
}

# Kubernetes Provider
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  token                  = data.aws_eks_cluster_auth.main.token
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

data "aws_eks_cluster_auth" "main" {
  name = module.eks.cluster_id
}

# Kubernetes Deployment
resource "kubernetes_deployment" "python_app" {
  metadata {
    name      = "python-app"
    namespace = "default"
    labels = { app = "python" }
  }

  spec {
    replicas = 2
    selector { match_labels = { app = "python" } }
    template {
      metadata { labels = { app = "python" } }
      spec {
        container {
          image = "your-docker-image"
          name  = "python-container"
          port { container_port = 5000 }
        }
      }
    }
  }
}
