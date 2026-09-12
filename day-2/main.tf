resource "aws_vpc" "name" {
  cidr_block = var.vpc_cidr
  tags={
    Name = "my_vpc"
    }
}

resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = var.subnet_cidr
    availability_zone = var.availability_zone

    tags = {
        Name = "my_subnet"
    }
}