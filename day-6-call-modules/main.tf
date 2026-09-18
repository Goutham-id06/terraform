module "dev" {
    source = "../day-6-modules"
    vpc_cidr = "10.0.0.0/16"
    subnet_cidr = "10.0.0.0/24"
    ami_id = "ami-0bd3fbcdc633a1b1a"
    instance_type = "t3.small"
    sg_name = "my_sg"
    sg_ingress_cidr = "0.0.0.0/0"
    sg_egress_cidr = "0.0.0.0/0"
    rt_cidr = "0.0.0.0/0"  
}