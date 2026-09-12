variable "vpc_cidr"{
    description = "cidr block for vpc"
    type = string
    default = "10.0.0.0/16"
}

variable "subnet_cidr"{
    description = "cidr block for subnet"
    type = string
    default = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
  default     = "us-east-1a"
}