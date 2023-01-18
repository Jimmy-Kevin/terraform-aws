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
  region = "us-west-1"
}

resource "aws_key_pair" "master-key" {
  key_name   = "kube-master-key"
  public_key = file("/root/.ssh/id_rsa.pub")
}

resource "aws_instance" "kube-master" {
  ami           = "ami-0fb6aae5c678c89fa"
  instance_type = "t2.micro"
  key_name = "kube-master-key"

  tags = {
    Name = var.instance_name
  }
}

