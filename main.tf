provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "vpc" {
  source = "modules/vpc/"
  vpc_cidr = "18.10.0.0/16"
  vpc_name = "Core"
  vpc_private_subnets = ["18.10.1.0/24", "18.10.2.0/24", "18.10.3.0/24"]
  vpc_public_subnets = ["18.10.11.0/24", "18.10.12.0/24", "18.10.13.0/24"]
  vpc_backend_subnets = ["18.10.21.0/24", "18.10.22.0/24", "18.10.23.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = true
  create_backend_subnet_route_table = true
}  

