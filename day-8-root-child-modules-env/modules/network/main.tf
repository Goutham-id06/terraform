resource "aws_vpc" "dev" {
    cidr_block = var.vpc_cidr
}

data "aws_availability_zone" "selected" {
  name  = var.availability_zone
  state = "available"
}

resource "aws_subnet" "dev" {
    vpc_id            = aws_vpc.dev.id
    cidr_block        = var.subnet_cidr
    availability_zone = data.aws_availability_zone.selected.name
}

output "subnet_id" {
    value = aws_subnet.dev.id
}