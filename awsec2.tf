terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.28.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "eu-central-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0c9354388bb36c088"
  instance_type = "t2.micro"
  vpc_security_group_ids = "sg-090d33fde578e6e1f"

  tags = {
    Name = "terraform-example"
  }
}