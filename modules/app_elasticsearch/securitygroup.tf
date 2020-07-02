//resource "aws_security_group" "sg_el" {
//  name   = "hamza-elaouane-sg_el"
//  vpc_id = var.vpc-id
//}
//
//resource "aws_security_group_rule" "el_eph_inbound_access" {
//  from_port         = 1024
//  protocol          = "tcp"
//  security_group_id = aws_security_group.sg_el.id
//  to_port           = 65535
//  type              = "ingress"
//  cidr_blocks       = ["10.0.0.0/16"]
//}
//
//resource "aws_security_group_rule" "el_eph_outbound_access" {
//  from_port         = 1024
//  protocol          = "tcp"
//  security_group_id = aws_security_group.sg_el.id
//  to_port           = 65535
//  type              = "egress"
//  cidr_blocks       = ["10.0.0.0/16"]
//}
//
//resource "aws_security_group_rule" "el__eph_outbound_access" {
//  from_port         = 0
//  protocol          = "-1"
//  security_group_id = aws_security_group.sg_el.id
//  to_port           = 0
//  type              = "egress"
//  cidr_blocks       = ["10.0.0.0/16"]
//}






resource "aws_security_group" "elk-security-group" {
  vpc_id = var.vpc-id
  name = "allow-elk-${var.ENV}"
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
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port = 1024
    protocol = "tcp"
    to_port = 65535
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
  from_port = 0
  protocol = "-1"
  to_port = 0
  cidr_blocks = ["0.0.0.0/0"]

  }



}