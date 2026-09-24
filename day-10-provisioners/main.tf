
provider "aws" {
    
}

resource "aws_key_pair" "example" {
    key_name = "my_key"
    public_key = file("~/.ssh/id_ed25519.pub")

}

resource "aws_vpc" "dev" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my_vpc"
    }
}

resource "aws_subnet" "dev_sub" {
    vpc_id = aws_vpc.dev.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "dev_igw" {
    vpc_id = aws_vpc.dev.id
}

resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.dev.id
    
    route = {
        source = "0.0.0.0"
        gateway_id = aws_internet_gateway.dev_igw.id
    }
}

resource "aws_route_table_association" "rta" {
    subnet_id = aws_subnet.dev_sub
    route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "sg" {
    name = "my_sg"
    vpc_id = aws_vpc.dev.id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
     }

     egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
     }

     tags = {
        Name = "my_sg"
     }

}

resource "aws_instance" "ec2" {
    ami = "ami-0b6d9d3d33ba97d99"
    instance_type = "t3.micro"
    key_name = aws_key_pair.example.key_name
    vpc_security_group_ids = [aws_security_group.sg.id]
    subnet_id = aws_subnet.dev_sub.id

    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("~/.ssh/id_ed25519")
        host = self.public_ip

    }

    #file provisioner
    provisioner "file" {
        source = "app.py"
        destination = "/home/ubuntu/app.py"
    }

    #remote exec provisioner
    provisioner "remote-exec" {
    inline = [
      "echo 'Hello from the remote instance'",
      "sudo apt update -y", 
      "sudo apt-get install -y python3-pip",  
      "cd /home/ubuntu",
      "sudo pip3 install flask",
      "sudo python3 app.py &",
    ]
    }

    #local exce provisioner
    provisioner "local-exec" {
    command = "touch local_file" 
    }

}