resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "my_vpc"
    }
}

variable "allowed_ports" {
    type = map(string)
    default = {
        22 = "10.0.1.0/24"
        80 = "10.0.2.0/24"
    }
}

resource "aws_security_group" "my_sg" {
    name = "my_sg"
    vpc_id = aws_vpc.my_vpc.id

    dynamic "ingress" {
        for_each = var.allowed_ports
        content {
            from_port = ingress.key
            to_port = ingress.key
            protocol = "tcp"
            cidr_blocks = [ ingress.value ]
        }

    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}