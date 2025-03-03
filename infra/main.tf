provider "aws" {
  region = "us-east-1"  # Change to your preferred region
}

resource "aws_iam_user" "dummy_user" {
  name = "dummy-user-${uuid()}"  # Unique name for the user
}

output "dummy_user_name" {
  value = aws_iam_user.dummy_user.name
}


