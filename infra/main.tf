provider "aws" {
  region = "us-west-2" // Change to your preferred region
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "python-app-cluster"
  cluster_version = "1.27"

  vpc_id          = "vpc-12345678" // Replace with your VPC ID
  subnet_ids      = ["subnet-12345678", "subnet-87654321"] // Replace with your subnet IDs

  eks_managed_node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = ["t3.medium"]
    }
  }
}

resource "kubernetes_deployment" "python_app" {
  metadata {
    name = "python-app"
    labels = {
      app = "python-app"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "python-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "python-app"
        }
      }

      spec {
        container {
          name  = "python-app"
          image = "your-docker-repo/python-app:latest" // Replace with your Docker image
          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "python_app" {
  metadata {
    name = "python-app-service"
  }

  spec {
    selector = {
      app = kubernetes_deployment.python_app.metadata[0].labels.app
    }

    port {
      port        = 80
      target_port = 5000
    }

    type = "LoadBalancer"
  }
}
