resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my_vpc"
    }
}

resource "aws_security_group" "my_sg" {
    name = "my_sg"
    vpc_id = aws_vpc.my_vpc.id
    
    ingress = [
        for port in [80 , 22 ] : {
            description = "inbound rules"
            from_port = port
            to_port = port 
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
            ipv6_cidr_blocks = []
            prefix_list_ids =[]
            security_groups = []
            self = false
        }
    ]

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}