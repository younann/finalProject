# Declare the VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# Declare the ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "example-ecs-cluster"
}

# Declare the ECS Task Definition
resource "aws_ecs_task_definition" "app" {
  family                   = "example-app"
  container_definitions    = <<DEFINITION
  [
    {
      "name": "example-app",
      "image": "nginx:latest",
      "memory": 256,
      "cpu": 256,
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ]
    }
  ]
  DEFINITION
}

# Declare the ECS Service
resource "aws_ecs_service" "app" {
  name            = "example-ecs-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
}
