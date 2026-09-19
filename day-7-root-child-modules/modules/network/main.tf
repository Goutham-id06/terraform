#create vpc
resource "aws_vpc" "dev" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "my_vpc"
    }
}

#create subnet
resource "aws_subnet" "dev-subnet" {
    cidr_block = var.subnet_cidr
    vpc_id = aws_vpc.dev.id
    tags = {
        Name ="my_subnet"
    }

}

#output subnet id
output subnet_id {
    value = aws_subnet.dev-subnet.id

}

