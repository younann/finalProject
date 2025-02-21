# Configure the required providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  required_version = ">= 1.2.0"
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region  # Now using the variable
}

# Example resource (you can uncomment and modify as needed)
# resource "aws_instance" "example" {
#   ami           = "ami-0c55b159cbfafe1f0"
#   instance_type = "t2.micro"
#   
#   tags = {
#     Name = "example-instance"
#   }
# } 