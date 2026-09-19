resource "aws_instance" "ec2" {
    subnet_id = var.subnet_id
    ami = var.ami_id
    instance_type = var.instance_type
    availability_zone = "var.availability_zone"
    tags = {
        Name = "my_ec2"
    }
}