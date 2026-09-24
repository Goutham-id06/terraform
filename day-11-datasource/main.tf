provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "dev" {
  filter {
    name   = "tag:Name"
    values = ["my_vpc"]
  }
}

data "aws_subnet" "dev_subnet" {
  filter {
    name   = "tag:Name"
    values = ["my_subnet"]
  }
}

data "aws_ami" "amazonlinux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

resource "aws_instance" "name" {
  ami                         = data.aws_ami.amazonlinux.id
  instance_type               = "t3.small"
  subnet_id                   = data.aws_subnet.dev_subnet.id
  associate_public_ip_address = true

  tags = {
    Name = "data-source-ec2"
  }
}