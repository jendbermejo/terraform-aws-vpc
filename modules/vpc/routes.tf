locals {
  max_subnet_length = "${max(length(var.vpc_private_subnets), length(var.vpc_backend_subnets))}"
  nat_gateway_count = "${var.single_nat_gateway ? 1 : (var.one_nat_gateway_per_az ? length(var.vpc_azs) : local.max_subnet_length)}"
}

resource "aws_route_table" "public" {
  count = "${var.create_vpc && length(var.vpc_public_subnets) > 0 ? 1 : 0}"
  vpc_id = "${aws_vpc.main.id}"
  tags = "${merge(map("Name", format("%s-public-rt", var.vpc_name)), var.public_route_table_tags, var.tags)}"
}

resource "aws_route_table" "private" {
  count = "${var.create_vpc && local.max_subnet_length > 0 ? local.nat_gateway_count : 0}"
  vpc_id = "${aws_vpc.main.id}"
  tags = "${merge(map("Name", (var.single_nat_gateway ? "${var.vpc_name}-private-rt" : format("%s-private-%s", var.vpc_name, element(var.vpc_azs, count.index)))), var.private_route_table_tags, var.tags)}"

}

resource "aws_route_table" "backend" {
  count = "${var.create_vpc && var.create_backend_subnet_route_table && length(var.vpc_backend_subnets) > 0 ? 1 : 0}"
  vpc_id = "${aws_vpc.main.id}"
  tags = "${merge(var.tags, var.backend_route_table_tags, map("Name", "${var.vpc_name}-backend-rt"))}"
}

resource "aws_route" "public_internet_gateway" {
  count = "${var.create_vpc && length(var.vpc_public_subnets) > 0 ? 1 : 0}"
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}

resource "aws_route_table_association" "public" {
  count = "${var.create_vpc && length(var.vpc_public_subnets) > 0 ? length(var.vpc_public_subnets) : 0}"

  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private" {
  count = "${var.create_vpc && length(var.vpc_private_subnets) > 0 ? length(var.vpc_private_subnets) : 0}"

  subnet_id      = "${element(aws_subnet.private_subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, (var.single_nat_gateway ? 0 : count.index))}"
}

resource "aws_route_table_association" "backend" {
  count = "${var.create_vpc && length(var.vpc_backend_subnets) > 0 ? length(var.vpc_backend_subnets) : 0}"

  subnet_id      = "${element(aws_subnet.backend_subnet.*.id, count.index)}"
  route_table_id = "${element(coalescelist(aws_route_table.backend.*.id, aws_route_table.private.*.id), (var.single_nat_gateway || var.create_backend_subnet_route_table ? 0 : count.index))}"
}

