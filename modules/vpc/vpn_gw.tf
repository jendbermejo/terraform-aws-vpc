resource "aws_vpn_gateway" "this" {
  count = "${var.create_vpc && var.enable_vpn_gateway ? 1 : 0}"

  vpc_id = "${aws_vpc.main.id}"

  tags = "${merge(map("Name", format("%s", var.vpc_name)), var.vpn_gateway_tags, var.tags)}"
}

resource "aws_vpn_gateway_attachment" "this" {
  count = "${var.vpn_gateway_id != "" ? 1 : 0}"

  vpc_id = "${aws_vpc.main.id}"
  vpn_gateway_id = "${var.vpn_gateway_id}"
}

resource "aws_vpn_gateway_route_propagation" "public" {
  count = "${var.create_vpc && var.propagate_public_route_tables_vgw && (var.enable_vpn_gateway || var.vpn_gateway_id != "") ? 1 : 0}"

  route_table_id = "${element(aws_route_table.public.*.id, count.index)}"
  vpn_gateway_id = "${element(concat(aws_vpn_gateway.this.*.id, aws_vpn_gateway_attachment.this.*.vpn_gateway_id), count.index)}"
}

resource "aws_vpn_gateway_route_propagation" "private" {
  count = "${var.create_vpc && var.propagate_private_route_tables_vgw && (var.enable_vpn_gateway || var.vpn_gateway_id != "") ? length(var.vpc_private_subnets) : 0}"

  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  vpn_gateway_id = "${element(concat(aws_vpn_gateway.this.*.id, aws_vpn_gateway_attachment.this.*.vpn_gateway_id), count.index)}"
}

