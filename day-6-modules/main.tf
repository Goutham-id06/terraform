#create vpc
resource "aws_vpc" "dev" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "my_vpc"
    }
}

#create subnet
resource "aws_subnet" "dev_subnet" {
    vpc_id = aws_vpc.dev.id
    cidr_block = var.subnet_cidr
    tags = {
        Name = "my_subnet"
    }
}
#create sg
resource "aws_security_group" "dev_sg" {
    vpc_id = aws_vpc.dev.id
    name = var.sg_name
    description = "allow"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks =[var.sg_ingress_cidr]

    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.sg_egress_cidr]
    }

}

#create internet gateway
resource "aws_internet_gateway" "dev_igw" {
    vpc_id = aws_vpc.dev.id
    tags = {
        Name = "my_igw"
    }
}

#create route table 
resource "aws_route_table" "dev_rt" {
    vpc_id = aws_vpc.dev.id
    route {
        cidr_block = var.rt_cidr
        gateway_id = aws_internet_gateway.dev_igw.id
    }
}

#craete route table association
resource "aws_route_table_association" "dev_rta" {
    subnet_id = aws_subnet.dev_subnet.id
    route_table_id = aws_route_table.dev_rt.id
}

#create ec2 
resource "aws_instance" "dev_ec2" {
    subnet_id = aws_subnet.dev_subnet.id
    ami = var.ami_id
    instance_type = var.instance_type
    tags = {
        Name = "my_ec2"
    }
}