variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  default     = true
}

variable "vpc_name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  default     = "0.0.0.0/0"
}

variable "vpc_azs" {
  description = "A list of availability zones in the region"
  type        = "list"
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"] 
}

variable "vpc_region" {
  description = "AWS Region"
  default     = "eu-west-1"
}

variable "vpc_public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = "list"
  default     = []
}

variable "vpc_private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = "list"
  default     = []
}

variable "vpc_backend_subnets" {
  description = "A list backend  subnets inside the VPC"
  type 	      = "list"
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}
variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  default     = {}
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  default     = {}
}

variable "backend_subnet_tags" {
  description = "Additional tags for the private subnets"
  default     = {}
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  default     = false
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  default     = false
}

variable "reuse_nat_ips" {
  description = "Should be true if you don't want EIPs to be created for your NAT Gateways and will instead pass them in via the 'external_nat_ip_ids' variable"
  default     = false
}

variable "external_nat_ip_ids" {
  description = "List of EIP IDs to be assigned to the NAT Gateways (used in combination with reuse_nat_ips)"
  type        = "list"
  default     = []
}

variable "nat_gateway_tags" {
  description = "Additional tags for the NAT gateways"
  default     = {}
}

variable "nat_eip_tags" {
  description = "Additional tags for the NAT EIP"
  default     = {}
}

variable "igw_tags" {
  description = "Additional tags for the internet gateway"
  default     = {}
}

variable "create_backend_subnet_route_table" {
  description = "Controls if separate route table for database should be created"
  default     = false
}

variable "public_route_table_tags" {
  description = "Additional tags for the public route tables"
  default     = {}
}

variable "private_route_table_tags" {
  description = "Additional tags for the private route tables"
  default     = {}
}

variable "subnet_ids" {
  description = "The IDs of the public Subnets"
  type        = "list"
  default     = []
}

variable "one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`."
  default     = false
}

variable "backend_route_table_tags" {
  description = "Additional tags for the database route tables"
  default     = {}
}

variable "enable_vpn_gateway" {
  description = "Should be true if you want to create a new VPN Gateway resource and attach it to the VPC"
  default     = false
}

variable "vpn_gateway_id" {
  description = "ID of VPN Gateway to attach to the VPC"
  default     = ""
}

variable "vpn_gateway_tags" {
  description = "Additional tags for the VPN gateway"
  default     = {}
}

variable "propagate_private_route_tables_vgw" {
  description = "Should be true if you want route table propagation"
  default     = false
}

variable "propagate_public_route_tables_vgw" {
  description = "Should be true if you want route table propagation"
  default     = false
}
