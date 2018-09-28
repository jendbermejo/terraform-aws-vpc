resource "aws_subnet" "private_subnet" {
  count 		= "${var.create_vpc && length(var.vpc_private_subnets) > 0 ? length(var.vpc_private_subnets) : 0}"
  vpc_id     		= "${aws_vpc.main.id}"
  availability_zone     = "${element(var.vpc_azs, count.index)}"
  cidr_block 		= "${var.vpc_private_subnets[count.index]}"
  tags 			= "${merge(map("Name", format("%s-private-%s", var.vpc_name, element(var.vpc_azs, count.index))), var.private_subnet_tags, var.tags)}"
}

resource "aws_subnet" "public_subnet" {
  count 		= "${var.create_vpc && length(var.vpc_public_subnets) > 0 ? length(var.vpc_public_subnets) : 0}"
  vpc_id     		= "${aws_vpc.main.id}"
  availability_zone     = "${element(var.vpc_azs, count.index)}"
  cidr_block 		= "${var.vpc_public_subnets[count.index]}"
  tags 			= "${merge(map("Name", format("%s-public-%s", var.vpc_name, element(var.vpc_azs, count.index))), var.public_subnet_tags, var.tags)}"
}

resource "aws_subnet" "backend_subnet" {
  count 		= "${var.create_vpc && length(var.vpc_backend_subnets) > 0 ? length(var.vpc_backend_subnets) : 0}"
  vpc_id     		= "${aws_vpc.main.id}"
  availability_zone     = "${element(var.vpc_azs, count.index)}"
  cidr_block 		= "${var.vpc_backend_subnets[count.index]}"
  tags 			= "${merge(map("Name", format("%s-backend-%s", var.vpc_name, element(var.vpc_azs, count.index))), var.backend_subnet_tags, var.tags)}"
}
