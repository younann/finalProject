provider "aws" {
  region = var.region
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
}

# Create a Subnet
resource "aws_subnet" "example" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}

# Create an ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name
}

# Create an ECS Task Definition
resource "aws_ecs_task_definition" "app" {
  family                   = var.task_family
  container_definitions    = <<DEFINITION
  [
    {
      "name": "${var.task_family}",
      "image": "${var.docker_image}",
      "memory": 256,
      "cpu": 256,
      "essential": true,
      "portMappings": [
        {
          "containerPort": ${var.container_port},
          "hostPort": ${var.container_port}
        }
      ]
    }
  ]
  DEFINITION
}

# Create an ECS Service
resource "aws_ecs_service" "app" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1

  network_configuration {
    subnets = [aws_subnet.example.id]
  }
}
