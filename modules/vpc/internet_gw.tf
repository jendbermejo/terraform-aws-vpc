resource "aws_internet_gateway" "igw" {
  count = "${var.create_vpc && length(var.vpc_public_subnets) > 0 ? 1 : 0}"
  vpc_id = "${aws_vpc.main.id}"
  tags = "${merge(map("Name", format("%s", var.vpc_name)), var.igw_tags, var.tags)}"
}
