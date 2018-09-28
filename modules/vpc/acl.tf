resource "aws_network_acl" "public" {
  vpc_id = "${aws_vpc.main.id}"
  subnet_ids = ["${aws_subnet.public_subnet.*.id}"]

  ingress {
    protocol   = "tcp"
    action     = "allow"
    rule_no    = 100  
    cidr_block = "${aws_subnet.public_subnet.*.cidr_block[0]}" 
    from_port  = 0
    to_port    = 65535
  }
  ingress {
    protocol   = "tcp"
    action     = "allow"
    rule_no    = 101  
    cidr_block = "${aws_subnet.public_subnet.*.cidr_block[1]}" 
    from_port  = 0
    to_port    = 65535
  }
  ingress {
    protocol   = "tcp"
    action     = "allow"
    rule_no    = 102  
    cidr_block = "${aws_subnet.public_subnet.*.cidr_block[2]}" 
    from_port  = 0
    to_port    = 65535
  }
  ingress {
    protocol   = "tcp"
    action     = "allow"
    rule_no    = 103  
    cidr_block = "${aws_subnet.private_subnet.*.cidr_block[0]}" 
    from_port  = 0
    to_port    = 65535
  }
  ingress {
    protocol   = "tcp"
    action     = "allow"
    rule_no    = 104  
    cidr_block = "${aws_subnet.private_subnet.*.cidr_block[1]}" 
    from_port  = 0
    to_port    = 65535
  }
  ingress {
    protocol   = "tcp"
    action     = "allow"
    rule_no    = 105  
    cidr_block = "${aws_subnet.private_subnet.*.cidr_block[2]}" 
    from_port  = 0
    to_port    = 65535
  }

  tags {
    Name = "${var.vpc_name}-DMZ-ACL"
  }
}

resource "aws_network_acl" "private" {
  vpc_id = "${aws_vpc.main.id}"
  subnet_ids = ["${aws_subnet.private_subnet.*.id}"]

  ingress {
    protocol   = "tcp"
    action     = "allow"
    rule_no    = 100  
    cidr_block = "${aws_subnet.public_subnet.*.cidr_block[0]}" 
    from_port  = 0
    to_port    = 65535
  }
  ingress {
    protocol   = "tcp"
    action     = "allow"
    rule_no    = 101  
    cidr_block = "${aws_subnet.public_subnet.*.cidr_block[1]}" 
    from_port  = 0
    to_port    = 65535
  }
  ingress {
    protocol   = "tcp"
    action     = "allow"
    rule_no    = 102  
    cidr_block = "${aws_subnet.public_subnet.*.cidr_block[2]}" 
    from_port  = 0
    to_port    = 65535
  }
  ingress {
    protocol   = "tcp"
    action     = "allow"
    rule_no    = 103  
    cidr_block = "${aws_subnet.private_subnet.*.cidr_block[0]}" 
    from_port  = 0
    to_port    = 65535
  }
  ingress {
    protocol   = "tcp"
    action     = "allow"
    rule_no    = 104  
    cidr_block = "${aws_subnet.private_subnet.*.cidr_block[1]}" 
    from_port  = 0
    to_port    = 65535
  }
  ingress {
    protocol   = "tcp"
    action     = "allow"
    rule_no    = 105  
    cidr_block = "${aws_subnet.private_subnet.*.cidr_block[2]}" 
    from_port  = 0
    to_port    = 65535
  }

  tags {
    Name = "${var.vpc_name}-PRIVATE-ACL"
  }
}

resource "aws_network_acl" "backend" {
  vpc_id = "${aws_vpc.main.id}"
  subnet_ids = ["${aws_subnet.backend_subnet.*.id}"]

  ingress {
    protocol   = "tcp"
    action     = "allow"
    rule_no    = 100  
    cidr_block = "${aws_subnet.backend_subnet.*.cidr_block[0]}" 
    from_port  = 0
    to_port    = 65535
  }
  ingress {
    protocol   = "tcp"
    action     = "allow"
    rule_no    = 101  
    cidr_block = "${aws_subnet.backend_subnet.*.cidr_block[1]}" 
    from_port  = 0
    to_port    = 65535
  }
  ingress {
    protocol   = "tcp"
    action     = "allow"
    rule_no    = 102  
    cidr_block = "${aws_subnet.backend_subnet.*.cidr_block[2]}" 
    from_port  = 0
    to_port    = 65535
  }
  ingress {
    protocol   = "tcp"
    action     = "allow"
    rule_no    = 103  
    cidr_block = "${aws_subnet.private_subnet.*.cidr_block[0]}" 
    from_port  = 0
    to_port    = 65535
  }
  ingress {
    protocol   = "tcp"
    action     = "allow"
    rule_no    = 104  
    cidr_block = "${aws_subnet.private_subnet.*.cidr_block[1]}" 
    from_port  = 0
    to_port    = 65535
  }
  ingress {
    protocol   = "tcp"
    action     = "allow"
    rule_no    = 105  
    cidr_block = "${aws_subnet.private_subnet.*.cidr_block[2]}" 
    from_port  = 0
    to_port    = 65535
  }

  tags {
    Name = "${var.vpc_name}-BACKEND-ACL"
  }
}
