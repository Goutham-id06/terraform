variable "ami_id" {
    type = string
    default = "null"
}

variable "instance_type" {
    type = string
    default = "null"
}

variable "subnet_id" {
    type = string
    default= "null"
}

variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}