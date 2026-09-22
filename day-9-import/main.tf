provider "aws" {
    region = "us-west-2"

}

resource "aws_instance" "dev" {
    ami = "ami-075d448db8fb256af"
    instance_type = "t3.micro"


}