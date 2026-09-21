module "network" {
	source            = "../../modules/network"
	vpc_cidr          = "10.0.0.0/16"
	subnet_cidr       = "10.0.1.0/24"
	availability_zone = "us-east-1a"
}

module "compute" {
    source = "../../modules/compute"
    ami_id = "ami-0fef201115eefe936"
    instance_type = "t3.small"
    subnet_id = module.network.subnet_id

}