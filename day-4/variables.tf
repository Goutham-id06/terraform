variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type = string
}

variable "subnet1_cidr" {
    description = "cidr for subnet-1"
    type = string
}

variable "subnet2_cidr" {
    description = "cidr for subnet-2"
    type = string
}

variable "db_name" {
    description = "Name of the database"
    type = string
}

variable "username" {
    description = "Username for the database"
    type = string
}

variable "password" {
    description = "Password for the database"
    type = string
}