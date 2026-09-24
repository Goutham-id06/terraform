provider "aws" {
    region = "us-east-1"
}

variable "tag" {
    default = [ "test" ,"prod"]
    type = list(string)
  
}

resource "aws_instance" "ec2" {
  ami = "ami-0e34b50e714a297f1"
  instance_type = "t3.micro"
  count = length(var.tag)
  tags = {
    Name = var.tag[count.index]
  }

}