terraform {
/*
  cloud {
    organization = "kuo"
    workspaces {
      name = "learn-tfc-aws"
    }
  }
*/

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("/root/.ssh/id_rsa.pub")
}

resource "aws_instance" "app_server" {
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"
  key_name = "deployer-key"

  tags = {
    Name = var.instance_name
  }
}

