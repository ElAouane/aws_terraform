//resource "aws_security_group" "sg_k" {
//  name   = "hamza-elaouane-sg-k"
//  vpc_id = "${var.vpc-id}"
//}
//
//resource "aws_security_group_rule" "k_eph_inbound_access" {
//  from_port         = 1024
//  protocol          = "tcp"
//  security_group_id = "${aws_security_group.sg_k.id}"
//  to_port           = 65535
//  type              = "ingress"
//  cidr_blocks       = ["10.0.0.0/16"]
//}
//
//#All inbound access
//resource "aws_security_group_rule" "k_all_inbound_access" {
//  from_port         = 1024
//  protocol          = "-1"
//  security_group_id = aws_security_group.sg_k.id
//  to_port           = 65535
//  type              = "ingress"
//  cidr_blocks       = ["0.0.0.0/0"]
//}
//
//resource "aws_security_group_rule" "k_eph_outbound_access" {
//  from_port         = 1024
//  protocol          = "tcp"
//  security_group_id = aws_security_group.sg_k.id
//  to_port           = 65535
//  type              = "egress"
//  cidr_blocks       = ["10.0.0.0/16"]
//}
//
//#All outbound access
//resource "aws_security_group_rule" "k_all_outbound_access" {
//  from_port         = 1024
//  protocol          = "-1"
//  security_group_id = aws_security_group.sg_k.id
//  to_port           = 65535
//  type              = "egress"
//  cidr_blocks       = ["0.0.0.0/0"]
//}













resource "aws_security_group" "Kibana-security-group" {
  vpc_id = var.vpc-id
  name = "allow-kibana-${var.ENV}"
  description = "security group that allows ssh and all egress traffic"

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow-ssh"
    Environment = var.ENV
  }

  ingress {
    from_port = 1024
    protocol = "tcp"
    to_port = 65535
    cidr_blocks = ["82.3.162.192/32"] #my ip

  }

  egress {
    from_port = 1024
    protocol = "tcp"
    to_port = 65535
    cidr_blocks = ["82.3.162.192/32"] # my ip

  }
  egress {
  from_port = 0
  protocol = "-1"
  to_port = 0
  cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port = 1024
    protocol = "tcp"
    to_port = 65535
    security_groups = [var.elastic-security-group]
  }

  egress {
    from_port = 1024
    protocol = "tcp"
    to_port = 65535
    security_groups = [var.elastic-security-group]

  }

}