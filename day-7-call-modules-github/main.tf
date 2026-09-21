module "network" {
    source = "github.com/Goutham-id06/terraform/day-7-root-child-modules/modules/network"
    vpc_cidr = "10.0.0.0/16"
    subnet_cidr = "10.0.1.0/24"
}
