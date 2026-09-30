locals {
  vpc_cidr = "10.0.0.0/16"
  vpc_tags = "my_vpc"
  region = "us-east-1"
  instnce_type = "t3.small"
  ami = "ami-02dfbd4ff395f2a1b"
  instance_tags = "my_ec2"
}

resource "aws_vpc" "my_vpc" {
    cidr_block = local.vpc_cidr

    tags = {
        Name = local.vpc_tags
    }
}

resource "aws_instance" "my_ec2" {
    region = local.region
    instance_type = local.instnce_type
    ami = local.ami
    tags = {
        Name = local.instance_tags
    }
}