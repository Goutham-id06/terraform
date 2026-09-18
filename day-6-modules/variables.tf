variable "vpc_cidr" {
    type = string
    default = "null"
}

variable "subnet_cidr" {
    type = string 
    default = "null"
}

variable "ami_id" {
    type = string
    default = "null"
}

variable "instance_type" {
    type = string
    default = "null"
}

variable "sg_name" {
    type = string
    default = "null"
}

variable "sg_ingress_cidr" {
    type = string
    default = "null"
}

variable "sg_egress_cidr" {
    type = string
    default = "null"

}

variable "rt_cidr" {
    type = string
    default = "null"
}
