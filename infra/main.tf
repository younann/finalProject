provider "aws" {
  region     = "us-east-1"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello, World!' > index.html",
      "sudo mv index.html /var/www/html/"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("${var.private_key_path}")
      host        = self.public_ip
    }
  }
}



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
  version         = "20.33.1"  # Ensure you're using a compatible version
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
